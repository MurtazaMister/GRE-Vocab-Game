import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/response.dart';
import '../Models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _users = _firestore.collection('users');

class FirebaseCrud {
  // static Future<Response> addUser({
  //   required String first_name,
  //   required String last_name,
  //   required String username,
  //   required String password,
  //   required String email,
  // }) async {
  //
  //   Response response = Response();
  //   DocumentReference documentReferencer =
  //   _users.doc();
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "first_name": first_name,
  //     "last_name": last_name,
  //     "username" : username,
  //     "password" : password,
  //     "email" : email,
  //
  //   };
  //
  //   var result = await documentReferencer
  //       .set(data)
  //       .whenComplete(() {
  //     response.code = 200;
  //     response.message = "Successfully added to the database";
  //   })
  //       .catchError((e) {
  //     response.code = 500;
  //     response.message = e;
  //   });
  //
  //   return response;
  // }

  static Future<String?> addUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    CollectionReference users = _firestore.collection("users");
    try {
      users.add({
        "first_name": first_name,
        "last_name": last_name,
        "username": username,
        "password": password,
        "email": email,
      });
      return null;
    } on Exception catch (err) {
      return "error";
    }
  }

  static Future<QuerySnapshot<Object?>> readUsers() {
    CollectionReference userCollection = _firestore.collection("users");

    return userCollection.get();
  }

  static bool verifyUsername(String username) {
    bool duplicateUsers = false;
    Query<Map<String, dynamic>> users;
    _firestore
        .collection("users")
        .where("username", isEqualTo: username)
        .get()
        .then((value) => {
              if (value.size > 0) {duplicateUsers = true}
            });
    return duplicateUsers;
  }

  // static Stream<QuerySnapshot> readUser({@required String username}) {
  //   DocumentReference userReferencer =
  //   _users.doc(username);
  //
  //   return userCollection.snapshots();
  // }

  //

  static Future<String?> updateUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    DocumentReference documentReferencer = _users.doc(username);
    try {
      documentReferencer.set({
        "first_name": first_name,
        "last_name": last_name,
        "username": username,
        "password": password,
        "email": email,
      });
      return null;
    } on Exception catch (err) {
      return "error";
    }
  }
  // static Future<Response> updateUser({
  //   required String first_name,
  //   required String last_name,
  //   required String username,
  //   required String password,
  //   required String email,
  // }) async {
  //   Response response = Response();
  //   DocumentReference documentReferencer =
  //   _users.doc(username);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "first_name": first_name,
  //     "last_name": last_name,
  //     "username" : username,
  //     "password" : password,
  //     "email" : email,
  //   };

  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() {
  //     response.code = 200;
  //     response.message = "Successfully updated User";
  //   })
  //       .catchError((e) {
  //     response.code = 500;
  //     response.message = e;
  //   });

  //   return response;
  // }

  static Future<Response> deleteUser({required String username}) async {
    Response response = Response();
    DocumentReference documentReferencer = _users.doc(username);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully Deleted User";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
