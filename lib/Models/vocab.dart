// import "Word.dart";

class Vocab {
  String? word;
  String? definition;
  // List<Map<String, String>>? synonyms;
  List<String>? synonyms;

  String? examples;

  Vocab({this.word, this.definition, this.synonyms, this.examples});

  void addSynonyms(String? synonyms ) {
    // check if the vocab for the synonym already exist
    // if yes fetch the id for that synonym from vocab and 
    // make {}
  }

  List<String>? getSynonyms() {
    return synonyms;
  } 

}