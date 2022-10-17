/**
 * Gre Vocab Game
 */

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';

import '../utils/text_theme.dart';

class AddVocab extends StatefulWidget {
  const AddVocab({Key? key}) : super(key: key);

  @override
  State<AddVocab> createState() => _AddVocabState();
}

/// UI for Add vocab page
///
/// Contains form having feilds [_word], [_definition], [_synonyms], [_example]
/// All Feilds are the controller fields
/// Form having the form key and widgets associated with controller
/// Widgets are also having their validation
/// And a Add button that runs function for add vocab
/// which uses the add method of firebase_vocab
class _AddVocabState extends State<AddVocab> {
  TextEditingController _word = TextEditingController();
  TextEditingController _definition = TextEditingController();
  TextEditingController _synonyms = TextEditingController();
  TextEditingController _example = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Call the method for add vocab
  ///
  /// send word, definition, example as a string
  /// split the _synonyms string which is seperated by ,
  /// And make an array of list
  /// and send to the add function of firebase_vocab
  /// clear the data from the textFormFeild after clicking add button
  addVocabFunction(BuildContext context) async {
    List<String> allSynonyms = _synonyms.text.split(",");

    /// Call the method for add by passing neccesary parameters
    ///
    /// Clear the form feild after calling
    await FirebaseVocab.addVocab(
        word: _word.text,
        definition: _definition.text,
        synonyms: allSynonyms,
        example: _example.text);

    _word.clear();
    _definition.clear();
    _synonyms.clear();
    _example.clear();
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
                controller: _word,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Write a word", labelText: "Word"),
              ),
              TextFormField(
                controller: _definition,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Write a definition", labelText: "Definition"),
              ),
              TextFormField(
                controller: _synonyms,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Write a synonyms",
                    labelText: "Synonyms seperated by comma"),
              ),
              TextFormField(
                controller: _example,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Write a example", labelText: "Example"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () => (addVocabFunction(context)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text(
                      "ADD",
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
