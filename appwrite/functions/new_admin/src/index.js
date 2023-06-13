const sdk = require("node-appwrite");

/*
  'req' variable has:
    'headers' - object with request headers
    'payload' - request body data as a string
    'variables' - object with function variables

  'res' variable has:
    'send(text, status)' - function to return text response. Status code defaults to 200
    'json(obj, status)' - function to return JSON response. Status code defaults to 200

  If an error is thrown, a response with code 500 will be returned.
*/

module.exports = async function (req, res) {
  const client = new sdk.Client();

  const teams = new sdk.Teams(client);

  if (
    !req.variables['APPWRITE_FUNCTION_ENDPOINT'] ||
    !req.variables['APPWRITE_FUNCTION_API_KEY'] ||
    !req.variables['APPWRITE_FUNCTION_TEAM_ID'] ||
    !req.variables['APPWRITE_FUNCTION_PROJECT_ID']
  ) {
    console.error("Environment variables are not set. Function cannot use Appwrite SDK.");
    res.json({
      status: "error",
      msg: "variables not set"
    });
    return;
  } else {
    client
      .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
      .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(req.variables['APPWRITE_FUNCTION_API_KEY'])
      .setSelfSigned(true);
  }

let payload;
  //get payload
  try{
    payload = JSON.parse(req?.payload);
    if(!req.payload){
      console.error("Email not found in payload.");
      res.json({
        status: "error",
        msg: "Invalid Email."
      });
      return;
    }
  }
  catch(e){
    console.error("error in json");
    res.json({
      status: "error",
      msg: "An error occured in JSON."
    });
    return;
  }


  //add email to admins
  const promise = teams.createMembership(req.variables['APPWRITE_FUNCTION_TEAM_ID'], payload.email, [], 'https://cloud.appwrite.io');

  promise.then(function (response) {
    console.log(response);
    res.json({
      status: "done",
      msg: `Added ${payload.email} as Admin.`
    });
  }, function (error) {
    console.log(error);
    if(error.type=='team_invite_already_exists'){
      res.json({
        status: "error",
        msg: "Admin already exist."
      });
    }
    else{
      res.json({
        status: "error",
        msg: "An error occured. contact system admin."
      });
    }
  });


  // res.json({
  //   areDevelopersAwesome: payload.email,
  // });
};
