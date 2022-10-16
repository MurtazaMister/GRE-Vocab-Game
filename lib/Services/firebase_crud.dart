import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/response.dart';
import '../Models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _users = _firestore.collection('users');

class FirebaseCrud {
  
  static Future<String?> addUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    CollectionReference users = _firestore.collection("users");
    try {
      DocumentReference dr = users.doc(username);
      dr.set({
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

  static Future<bool> verifyUsername(String username) async {
    bool duplicateUsers = false;
    try {
      final value = await _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      if (value.size > 0) {
        duplicateUsers = true;
      }
    } catch (e) {}
    return duplicateUsers;
  }

  static Future<bool> verifyUser(String username, String password) async {
    bool isValid = false;
    try {
      final value = await _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .where("password", isEqualTo: password)
          .get();
      if (value.size > 0) {
        isValid = true;
      }
    } catch (e) {}
    return isValid;
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
 
  //TODO: check this 
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
