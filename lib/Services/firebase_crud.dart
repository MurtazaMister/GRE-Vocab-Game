/*
firebase_crud.dart is a file having Create, Read, and Update functionality for users
*/
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/response.dart';
import '../Models/user.dart';

// point the firebase instance
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// point the collection(Table) named "users" 
final CollectionReference _users = _firestore.collection('users');

// class having static methods for add, verify, update, delete
class FirebaseCrud {
  
  /* static method that receive parameters for 'user'
     make reference to the collection and add the user 
  */ 
  static Future<String?> addUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    CollectionReference users = _firestore.collection("users");
    try {
      // Reference for document
      // create a document with key 'username' if 'username' does not exist
      DocumentReference dr = users.doc(username);
      // add the data in form of json
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
  // checking if username already exist or not
  static Future<bool> verifyUsername(String username) async {
    bool duplicateUsers = false;
    try {
      // Query that get the user with 'username' = username
      final value = await _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      
      // if there exist any user then return true else return false
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

  // update user functionality
  static Future<String?> updateUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    // Referencing the document having 'username' = username
    DocumentReference documentReferencer = _users.doc(username);
    try {
      // Update the data for already existing user
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
