import 'package:cloud_firestore/cloud_firestore.dart';

class MainDatabase {

  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  /*
  How to use example
  MainDatabase Student = MainDatabase();
  Student.addStudent(id:"1101", name:"aman", room:"103", branch:"IT", mobile:"9756547687");
  */
  Future<void> addStudent({required String id,required String name,required String room,
                            required String branch,required String mobile, required String url}) async {
    Map<String, dynamic> stdData = {
      "id": id,
      "name": name,
      "roomNo": room,
      "branch": branch,
      "mobileNo":mobile,
      "imageUrl":url
    };
    await _fire.collection("users").doc(stdData['id']).set(stdData);
  }

  /*
  How to use example
  MainDatabase Student = MainDatabase();
  Map<String, dynamic> data;
  data = await Student.getInfo(id: "1101");
  if(kDebugMode){
    print(data);
  }*/
  Future<Map<String, dynamic>> getInfo({required String id}) async {

  DocumentSnapshot snap = await _fire.collection("users").doc(id).get();
  Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
  return data;
  }

  /*
  How to use example
  MainDatabase student = MainDatabase();
  student.updateRoom(id: "1101", newRoom: "330");
   */
  Future<void> updateRoom({required String id, required String room}) async{
    await _fire.collection("users").doc(id).update({
      "roomNo": room
    });
  }

  /*
  How to use example
  MainDatabase student = MainDatabase();
  student.updateBranch(id: "1101", branch: "CS");
   */
  Future<void> updateBranch({required String id, required String branch}) async{
    await _fire.collection("users").doc(id).update({
      "branch": branch
    });
  }

  /*
  How to use example
  MainDatabase student = MainDatabase();
  student.deleteStudent(id: "1102");
   */
  Future<void> deleteStudent({required String id}) async{
    await _fire.collection("users").doc(id).delete();
  }

}