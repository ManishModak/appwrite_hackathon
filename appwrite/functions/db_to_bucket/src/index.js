const sdk = require("node-appwrite");
const utf8 = require('utf8');



//json to csv
function arrayToCSV(data) {
  csv = data.map(row => Object.values(row));
  csv.unshift(Object.keys(data[0]));
  return `"${csv.join('"\n"').replace(/,/g, '","')}"`;
}


module.exports = async function (req, res) {
  const client = new sdk.Client();


  if (
    !req.variables['APPWRITE_FUNCTION_ENDPOINT'] ||
    !req.variables['APPWRITE_FUNCTION_LOGDBID'] ||
    !req.variables['APPWRITE_FUNCTION_LOGCOLLECTIONID'] ||
    !req.variables['APPWRITE_FUNCTION_API_KEY'] ||
    !req.variables['APPWRITE_FUNCTION_BUCKET_ID']
  ) {
    console.warn("Environment variables are not set. Function cannot use Appwrite SDK.");
    res.json({
      status: "error",
      msg: "variables not set"
    });
    return;
  }

  client
    .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
    .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
    .setKey(req.variables['APPWRITE_FUNCTION_API_KEY'])
    .setSelfSigned(true);

  const databases = new sdk.Databases(client);
  const storage = new sdk.Storage(client);

  //get latest entry
  const latest = await databases.listDocuments(req.variables['APPWRITE_FUNCTION_LOGDBID'], req.variables['APPWRITE_FUNCTION_LOGCOLLECTIONID'],
    [sdk.Query.limit(1),
    sdk.Query.orderDesc("$createdAt"),
    ]);
  //get oldest entry
  const oldest = await databases.listDocuments(req.variables['APPWRITE_FUNCTION_LOGDBID'], req.variables['APPWRITE_FUNCTION_LOGCOLLECTIONID'],
    [sdk.Query.limit(1),
    sdk.Query.orderAsc("$createdAt"),
    ]);

  //check if old data available
  if (latest.documents[0].date == oldest.documents[0].date) {
    res.json({
      status: "done",
      msg: "Old log not available"
    });
    return;
  }

  //if old data present get it
  const old = await databases.listDocuments(req.variables['APPWRITE_FUNCTION_LOGDBID'], req.variables['APPWRITE_FUNCTION_LOGCOLLECTIONID'],
    [
      sdk.Query.orderDesc("$createdAt"),
      sdk.Query.equal("date", [oldest.documents[0].date])
    ]);

  //check if all entries are closed
  var unClosedEntries = 0
  for (var i = 0; i < old.documents.length; i++) {
    if (old.documents[i].inTime == 'null') {
      unClosedEntries++
    }
  }

  if (unClosedEntries != 0) {
    console.log(unClosedEntries + ' Students have not returned. Returning from function')
    res.json({
      status: "abort",
      msg: unClosedEntries + ' Students have not returned. Returning from function'
    });
    return
  }

  //format data to save in csv
  var oldJson = [];
  for (var i = 0; i < old.documents.length; i++) {
    var tmpData = {
      id: old.documents[i].id,
      outTime: old.documents[i].outTime,
      inTime: old.documents[i].inTime,
      name: old.documents[i].name,
      roomNo: old.documents[i].roomNo,
    }
    oldJson.push(tmpData)
    // console.log(tmpData + '\n\n')
  }

  const csv = arrayToCSV(oldJson);


  const filename = oldest.documents[0].date + '.csv'
  utfCont = utf8.encode(csv)
  const promise = await storage.createFile(
    req.variables['APPWRITE_FUNCTION_BUCKET_ID'],
    oldest.documents[0].date,
    sdk.InputFile.fromPlainText(utfCont, filename));
  console.log('file uploaded')


  async function deleteDocuments(documents){
    for (var i = 0; i < documents.length; i++) {
      databases.deleteDocument(req.variables['APPWRITE_FUNCTION_LOGDBID'], req.variables['APPWRITE_FUNCTION_LOGCOLLECTIONID'], documents[i].$id);
    }
  }


  if(promise.$id == oldest.documents[0].date){
    //delete all data of that day
    await deleteDocuments(old.documents)
    console.log('deleted log from db')
    res.json({
      status: "done",
      msg: 'Work done, created ne file in storage'
    });
    return
  }



  console.log(oldJson)

  res.send(csv)

  // res.json({
  //   isOldPresent:inOldPresent
  // });
  // res.json({data : oldJson})
};
