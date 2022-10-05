import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/response.dart';
import '../Models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('users');
class FirebaseCrud {

  static Future<Response> addUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "first_name": first_name,
      "last_name": last_name,
      "username" : username,
      "password" : password,
      "email" : email,

    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateUser({
    required String first_name,
    required String last_name,
    required String username,
    required String password,
    required String email,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc(username);

    Map<String, dynamic> data = <String, dynamic>{
      "first_name": first_name,
      "last_name": last_name,
      "username" : username,
      "password" : password,
      "email" : email,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteUser({
    required String username,
    // required String password,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc(username);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}