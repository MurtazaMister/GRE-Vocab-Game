/**
 * Gre Vocab Game: hangman
 */

import 'dart:convert';
import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';
import 'package:gre_dictionary_game/pages/result.dart';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() => _HangmanState();
}

/// Hangman game for vocab prctice
///
/// Each Time a random vocab comes from the database
/// Player has to guess the correct word untill the man hangged
/// Player has limited chance for incorrect guess
/// Data is maintained for every correct and incorrect number of guess
///
/// [currentData] has snapshot of current vocab
/// [toGuess] has a word to be guessed
/// [currentString] maintains the correct guess by user
/// [currentImage] is the hangman image for every stage
/// [currentStep] counting the incorrect guess so that we find our terminating condition after a boundary value
/// [disabledAlphabets] for make an button disable after a correct guess
/// [isHintUsed] checks if the hint is used for the word or not
/// [reportData] has the all the report of the game
class _HangmanState extends State<Hangman> {
  Object? currentData = null;
  String toGuess = "";
  String currentString = "";
  String currentImage = 'assets/hangman/step0.jpg';
  int currentStep = 0;
  List<int> disabledAlphabets = List.filled(26, 0);

  TextStyle synonymStyle = new TextStyle(fontSize: 20);

  List<Object> reportData = [];
  num correctGuess = 0;
  bool isHintUsed = false;

  @override
  Widget build(BuildContext context) {
    List<Padding> alphabetButtonList = [];
    List<String> alphabets = [];
    for (int i = 0; i < 26; i++) {
      alphabets.add(String.fromCharCode(i + 65));
    }

    /// return the definition
    Text getHint(String definition) {
      return Text(definition);
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

    /// Initiailze a game with blank string
    /// Maintains the string after each and every guess
    /// If success make color of string green
    /// If Failure make color of string red
    /// otherwise black
    List<Text> getUnderscores(String word) {
      // print(currentString);
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

    /// Maintain all the changes after every alphabet click
    ///
    ///
    onSelect(String alphabet) {
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
        correctGuess++;
        for (int i = 0; i < available.length; i++) {
          currentString = currentString.substring(0, available[i]) +
              alphabet +
              currentString.substring(available[i] + 1);
        }
      }

      disabledAlphabets[alphabet.codeUnitAt(0) - 65] = 1;
      if (toGuess == currentString) {
        disabledAlphabets = List.filled(26, 1);
        reportData.add({
          "word": toGuess,
          "correctGuess": correctGuess,
          "incorrectGuess": currentStep,
          "isHintUsed": isHintUsed,
          "score": (7 - currentStep) * 100 - 25 * currentStep,
        });

        print(reportData);
      }
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
                  disabledAlphabets[i] == 0 ? Colors.green : Colors.grey,
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
            SizedBox(
              child: Image.asset(currentImage),
              width: 250,
              height: 250,
            ),
            currentStep >= 7
                ? Text(
                    "Game over",
                    style: TextStyle(fontSize: 40),
                  )
                : SizedBox.shrink(),
            FutureBuilder(
              future: gettingRandomVocab(),
              builder: (BuildContext context, snapshot) {
                print("------------ sanpshot dt -----------------");
                print(snapshot.data);
                List<Widget> children;
                if (snapshot.hasData) {
                  String word = snapshot.data
                      .toString()
                      .split(':')[3]
                      .split(',')[0]
                      .trim()
                      .toUpperCase();

                  List<String> synonyms =
                      snapshot.data.toString().split(':')[1].split(',');
                  synonyms.removeLast();
                  synonyms[0] = synonyms[0].split('[')[1];
                  synonyms[synonyms.length - 1] =
                      synonyms[synonyms.length - 1].split(']')[0];

                  String definition =
                      snapshot.data.toString().split(':')[2].split(',')[0];

                  toGuess = word;
                  print(word);
                  print(currentString.length);
                  if (correctGuess + currentStep == 0) {
                    print("@@@@@@@@@@@@@@@@@@@");
                    print(word);
                    currentString = '';
                    for (int i = 0; i < word.length; i++) {
                      currentString += '_';
                    }
                    currentData = snapshot.data;
                    print(currentString);
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
                          child: Wrap(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: getSynonyms(synonyms),
                            ),
                            !isHintUsed
                                ? FloatingActionButton.small(
                                  backgroundColor: Colors.green,
                                    onPressed: () {
                                      isHintUsed = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.thunderstorm),
                                  )
                                : getHint(definition),
                          ]),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result(
                                        reportData: reportData,
                                      )));
                        },
                        child: Text("End game")),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                        onPressed: () {
                          currentData = null;
                          toGuess = "";
                          currentString = "";
                          currentStep = 0;
                          correctGuess = 0;
                          disabledAlphabets = List.filled(26, 0);
                          currentImage = 'assets/hangman/step0.jpg';
                          isHintUsed = false;
                          print("****************");
                          print(currentString);
                          setState(() {});
                        },
                        child: Text("Next")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
