import 'dart:convert';

import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  Object? currentData = null;
  List<Object> reportData = [];
  String toGuess = "";
  String currentString = "";
  String currentImage = 'assets/hangman/step0.jpg';
  int currentStep = 0;
  List<int> disabledAlphabets = List.filled(26, 0);

  TextStyle synonymStyle = new TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    List<Padding> alphabetButtonList = [];
    List<String> alphabets = [];
    for (int i = 0; i < 26; i++) {
      alphabets.add(String.fromCharCode(i + 65));
    }

    List<Text> getSynonyms(List<String> synonyms) {
      List<Text> list = [
        Text(
          "Synonyms: | ",
          style: synonymStyle,
        )
      ];
      for (var i in synonyms) {
        list.add(Text(
          "$i | ",
          style: synonymStyle,
        ));
      }
      return list;
    }

    List<Text> getUnderscores(String word) {
      print(currentString);
      List<Text> list = [];
      for (var i in currentString.characters) {
        list.add(Text(
          ' ' + i + ' ',
          style: TextStyle(
              fontSize: 40,
              color: currentStep >= 7
                  ? Colors.red
                  : (toGuess == currentString)
                      ? Colors.green
                      : Colors.black),
        ));
      }
      return list;
    }

    onSelect(String alphabet) {
      if (toGuess == currentString) {
        disabledAlphabets = List.filled(26, 1);
        return;
      }
      List<int> available = [];
      for (int i = 0; i < toGuess.length; i++) {
        if (toGuess[i].toLowerCase() == alphabet.toLowerCase()) {
          available.add(i);
        }
      }
      if (available.length == 0) {
        currentStep++;
        if (currentStep >= 7) {
          currentString = toGuess;
          currentStep = 7;
        }
        currentImage = "assets/hangman/step" + currentStep.toString() + ".jpg";
      } else {
        for (int i = 0; i < available.length; i++) {
          currentString = currentString.substring(0, available[i]) +
              alphabet +
              currentString.substring(available[i] + 1);
        }
      }

      disabledAlphabets[alphabet.codeUnitAt(0) - 65] = 1;
      setState(() {});
    }

    List<Padding> getFloatingActionButtons() {
      for (int i = 0; i < 26; i++) {
        alphabetButtonList.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: SizedBox(
            height: 55,
            width: 45,
            child: FloatingActionButton(
              onPressed: disabledAlphabets[i] == 0
                  ? () {
                      onSelect(alphabets[i]);
                    }
                  : null,
              heroTag: i,
              child: Text(alphabets[i]),
              backgroundColor:
                  disabledAlphabets[i] == 0 ? Colors.blue : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ));
      }
      return alphabetButtonList;
    }

    Future<Object> gettingRandomVocab() async {
      if (currentData == null) {
        return await FirebaseVocab.getRandomVocab();
      } else {
        return Future<Object>.delayed(
            Duration(milliseconds: 1), (() => currentData as Object));
      }
    }

    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(currentImage),
            currentStep >= 7
                ? Text(
                    "Game over",
                    style: TextStyle(fontSize: 40),
                  )
                : SizedBox.shrink(),
            FutureBuilder(
              future: gettingRandomVocab(),
              builder: (BuildContext context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  currentData = snapshot.data;
                  List<String> synonyms =
                      snapshot.data.toString().split(':')[1].split(',');
                  synonyms.removeLast();
                  synonyms[0] = synonyms[0].split('[')[1];
                  synonyms[synonyms.length - 1] =
                      synonyms[synonyms.length - 1].split(']')[0];

                  String definition =
                      snapshot.data.toString().split(':')[2].split(',')[0];

                  String word = snapshot.data
                      .toString()
                      .split(':')[3]
                      .split(',')[0]
                      .trim()
                      .toUpperCase();

                  toGuess = word;
                  if (currentString.length == 0) {
                    for (int i = 0; i < word.length; i++) {
                      currentString += '_';
                    }
                  }

                  num len = word.length;

                  children = <Widget>[
                    // Text(
                    //     '${snapshot.data} -------------- synonym->${synonyms} def->${definition} word->${word}'),
                    Wrap(
                      children: getUnderscores(currentString),
                    ),
                    Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: getSynonyms(synonyms),
                          ),
                        )
                      ],
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
                      currentData = null;
                      toGuess = "";
                      currentString = "";
                      currentStep = 0;
                      disabledAlphabets = List.filled(26, 0);
                      currentImage = 'assets/hangman/step0.jpg';
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
