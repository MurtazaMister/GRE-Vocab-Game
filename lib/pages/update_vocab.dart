import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';

import '../utils/text_theme.dart';

class UpdateVocab extends StatefulWidget {
  var _word, _definition, _synonyms, _example;

   UpdateVocab({Key? key, @required o_word, @required o_definition, @required List<dynamic>? o_synonyms, @required o_example }) : super(key: key){
    _word = o_word;
    _definition = o_definition;
    _synonyms = o_synonyms?.join(",").toString();
    _example = o_example;

  }

  @override
  State<UpdateVocab> createState() => _UpdateVocabState(word: _word, definition: _definition, synonyms: _synonyms, example: _example);
}

class _UpdateVocabState extends State<UpdateVocab> {
  String? word1, definition1, synonyms1, example1;

  _UpdateVocabState({@required word, @required definition, @required synonyms, @required example}) {
    word1 = word;
    definition1 = definition;
    synonyms1 = synonyms;
    example1 = example;

    wordC.text = word1.toString(); 
    definitionC.text = definition1.toString(); 
    synonymsC.text = synonyms1.toString(); 
    exampleC.text = example1.toString();

  }

  TextEditingController wordC = TextEditingController();
  TextEditingController definitionC = TextEditingController();
  TextEditingController synonymsC = TextEditingController();
  TextEditingController exampleC = TextEditingController();

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    
   updateVocabFunction(BuildContext context) async {
    List<String> allSynonyms = synonymsC.text.split(",").map((e) => e.trim()).toList();

    await FirebaseVocab.updateVocab(word: wordC.text, definition: definitionC.text, synonyms: allSynonyms, example: exampleC.text);

    setState(() {
      
    });
   }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        left: true,
        right: true,
        minimum: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: wordC,
                enabled: false,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Write a word", labelText: "Word"
                ),
              ),

              TextFormField(
                controller: definitionC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Write a definition", labelText: "Definition"
                ),
              ),

              TextFormField(
                // initialValue: synonyms1,
                controller: synonymsC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Write a synonyms", labelText: "Synonyms seperated by comma"
                ),
              ),

              TextFormField(
                // initialValue: example1,
                controller: exampleC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Write a example", labelText: "Example"
                ),
              ),

              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () => (updateVocabFunction(context)),
                        // onPressed: () => (printVars()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                        child: Text(
                          "Update",
                          style: AppTheme.defaultStyle().merge(TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          )),
                        ),
                      ),
                    ),
                  )

            ],
          ),
        ),
      ),
    ); 
  }
}