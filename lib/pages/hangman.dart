import 'dart:convert';

import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  @override
  Widget build(BuildContext context) {
    List<Object> reportData = [];

    List<String> alphabets = [];
    for (int i = 0; i < 26; i++) {
      alphabets.add(String.fromCharCode(i + 65));
    }

    List<Text> getSynonyms(List<String> synonyms) {
      List<Text> list = [Text("Synonyms: | ")];
      for (var i in synonyms) {
        list.add(Text("$i | "));
      }
      return list;
    }

    List<Text> getUnderscores(String word) {
      List<Text> list = [];
      for (var i in word.characters) {
        if (i != ' ')
          list.add(Text(
            ' _ ',
            style: TextStyle(fontSize: 40),
          ));
      }
      return list;
    }

    List<FloatingActionButton> getFloatingActionButtons() {
      List<FloatingActionButton> list = [];
      for (var i in alphabets) {
        list.add(FloatingActionButton(
          onPressed: () => {},
          heroTag: i,
          child: Text(i),
        ));
      }
      return list;
    }

    Future<Object> gettingRandomVocab() async {
      return await FirebaseVocab.getRandomVocab();
    }

    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/hangman/step0.jpg'),
            FutureBuilder(
              future: gettingRandomVocab(),
              builder: (BuildContext context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  List<String> synonyms =
                      snapshot.data.toString().split(':')[1].split(',');
                  synonyms.removeLast();
                  synonyms[0] = synonyms[0].split('[')[1];
                  synonyms[synonyms.length - 1] =
                      synonyms[synonyms.length - 1].split(']')[0];

                  String definition =
                      snapshot.data.toString().split(':')[2].split(',')[0];

                  String word =
                      snapshot.data.toString().split(':')[3].split(',')[0];

                  num len = word.length;

                  children = <Widget>[
                    // Text(
                    //     '${snapshot.data} -------------- synonym->${synonyms} def->${definition} word->${word}'),
                    Wrap(
                      children: getUnderscores(word),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: getSynonyms(synonyms),
                      ),
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Your word is...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
            Wrap(
              children: [
                ...getFloatingActionButtons(),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("Next"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
