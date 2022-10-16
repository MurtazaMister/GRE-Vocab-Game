
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/vocab.dart';
import 'dart:math';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _vocab = _firestore.collection('vocab');

class FirebaseVocab{

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

  
  static Object getRandomVocab() async{

    QuerySnapshot qs = await _vocab.get();
    List<DocumentSnapshot> listedQS = qs.docs; //listed documents
    var random = new Random(); //dart math
    //shuffle the array
    for (var i = listedQS.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = listedQS[i];
      listedQS[i] = listedQS[n];
      listedQS[n] = temp;
    }
    DocumentSnapshot randomDocument = listedQS[0];
    return randomDocument.data();
  }
}
