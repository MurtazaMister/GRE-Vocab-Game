/*
firebase_vocab : having a class for operation with vocab collection

It is having functionalities like:
  1- addVocab()
  2- updateVocab()
  -3 getRandomVocab()
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/vocab.dart';
import 'dart:math';

// point to the firebase instance 
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// Reference to the collection named "vocab"
final CollectionReference _vocab = _firestore.collection('vocab');

// class FireBaseVocab having above three functionalities
class FirebaseVocab {
  // Add vocab in vocab collection
  static Future<String?> addVocab(
      {required String word,
      required String definition,
      required List<String> synonyms,
      required String example}) async {
    
    // Create the document with "id" = word  
    DocumentReference documentReference = _vocab.doc(word);
    try {
      // Add data to the document
      documentReference.set({
        "word": word,
        "definition": definition,
        "synonyms": synonyms,
        "example": example
      });
      return null;
    } on Exception catch (err) {
      return "error";
    }
  }

  // Update Vocab
  static Future<String?> updateVocab(
      {required String word,
      required String definition,
      required List<String> synonyms,
      required String example}) async {
    
    //Reference to already existing word with "id": word 
    DocumentReference documentReference = _vocab.doc(word);
    try {
      // update the vocab with new data
      documentReference.set({
        "word": word,
        "definition": definition,
        "synonyms": synonyms,
        "example": example
      });
      return null;
    } on Exception catch (err) {
      return "error";
    }
  }

  // Get Random vocab for the hangman game 
  static Object getRandomVocab() async {
    QuerySnapshot qs = await _vocab.get();
    List<DocumentSnapshot> listedQS = qs.docs; //listed documents
    var random = new Random(); //dart math
    DocumentSnapshot randomDocument = listedQS[random.nextInt(listedQS.length)];
    return randomDocument.data();
    // //shuffle the array
    // for (var i = listedQS.length - 1; i > 0; i--) {
    //   var n = random.nextInt(i + 1);
    //   var temp = listedQS[i];
    //   listedQS[i] = listedQS[n];
    //   listedQS[n] = temp;
    // }
  }
}
