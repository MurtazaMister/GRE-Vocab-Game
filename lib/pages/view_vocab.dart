import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gre_dictionary_game/pages/update_vocab.dart';

class ViewVocab extends StatelessWidget {
  String word="", definition="", example="";
  List<dynamic> synonyms = [];
  ViewVocab({Key? key, required String word, required String definition, required List<dynamic> synonyms, required String example}) : super(key: key){
    this.word = word;
    this.synonyms = synonyms;
    this.definition = definition;
    this.example = example;
  }

  List<Text> getSynonyms(List<dynamic> synonyms){
    List<Text> list = [];
    for(var synonym in synonyms){
        list.add(Text(synonym, style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),));
    }
    return list;
  }

  moveToUpdateVocab(BuildContext context, String word, String definition, List<dynamic> synonyms, String example) async {
    
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => UpdateVocab(
        o_word: word,
        o_definition: definition,
        o_synonyms: synonyms,
        o_example: example,
      )));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
                            
                            onPressed: () {
                              
                              moveToUpdateVocab(context, word.toString(), definition, synonyms, example);
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.edit),
                          ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text("WORD:", style: TextStyle(fontSize: 15),),
              SizedBox(width: 5,),
              Text(word, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
            ],
            ),
            SizedBox(height: 20,),
            definition.length>0?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DEFINITION:", style: TextStyle(fontSize: 15),),
              SizedBox(width: 10,),
              Wrap(children: [Text(definition, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),)]),
            ],
            ):SizedBox.shrink(),
            SizedBox(height: 20,),
            synonyms.length>0?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SYNONYMS:", style: TextStyle(fontSize: 15),),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: getSynonyms(synonyms)),
              ),
            ],
            ):SizedBox.shrink(),
            SizedBox(height: 20,),
            example.length>0?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EXAMPLE:", style: TextStyle(fontSize: 15),),
              SizedBox(width: 10,),
              Wrap(children: [Text(example, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)]),
            ],
            ):SizedBox.shrink(),
          ]),
        ),
      ),
    );
  }
}