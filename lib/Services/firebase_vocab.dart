
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/vocab.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _vocab = _firestore.collection('vocab');

class FirebaseVocab{

  /*TODO: check whether the word is already exist or not */
  // static Future<String?> addVocab({
  //   required String word,
  //   required String definition,
  //   required List<String> synonyms,
  //   required String example
  // }) async {
  //   try{
  //     _vocab.add({
  //       "word": word,
  //       "definition": definition,
  //       "synonyms": synonyms,
  //       "example": example
  //     });
  //     return null;
  //   } on Exception catch (err) {
  //     return "error";
  //   }
  // }

  // static Future<String?> addVocab({
  //   required String word,
  //   required String definition,
  //   required List<String> synonyms,
  //   required String example
  // }) async {
  //   DocumentReference dr = _vocab.doc(word);

  //   Map<String, dynamic> vocab = {
  //     "word": word,
  //     "definition": definition,
  //     "synonyms": synonyms,
  //     "example": example
  //   };

  //   dr.setData
  // }

   static Future<String?> addVocab({
    required String word,
    required String definition,
    required List<String> synonyms,
    required String example
  }) async {
    DocumentReference documentReference = _vocab.doc(word);
    try{
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

  static Future<String?> updateVocab({
    required String word,
    required String definition,
    required List<String> synonyms,
    required String example
  }) async {
    DocumentReference documentReference = _vocab.doc(word);
    try{
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
}