/*
  Gre Vocab Game
*/
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/response.dart';
import '../Models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _users = _firestore.collection('users');

/// Defining the crud operation on user data
///
/// [addUser] add the newly registered user
/// [verifyUsername] checks if the same username is already exist or not
/// [verifyUser] used for user is exist for username and password to allow him/her to login
/// [updateUser] used to change user profile
class FirebaseCrud {
  /// Add new user with id [username] in database
  /// It points to the collection named 'users' in the database
  /// and referencing the already existing user with username named [username]
  /// and update the old data with passed parameters
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

  static Future<Map<String,dynamic>> verifyUser(String username, String password) async {
    Map<String,dynamic> user=Map();
    user["isValid"] = false;
    try {
      final value = await _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .where("password", isEqualTo: password)
          .get();
      if (value.size > 0) {
        user["isValid"] = true;
        value.docs.forEach((doc){
          user["username"] = doc["username"];
          user["first_name"] = doc["first_name"];
          user["last_name"] = doc["last_name"];
          user["password"] = doc["password"];
          user["email"] = doc["email"];
        });
      }
    } catch (e) {}
    return user;
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
    DocumentReference documentReferencer = await _users.doc(username);
    try {
      // Update the data for already existing user
      await documentReferencer.set({
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
