import "package:flutter/material.dart";
import 'package:gre_dictionary_game/pages/hangman.dart';
import 'package:gre_dictionary_game/pages/homepage.dart';

class Result extends StatelessWidget {
  List reportData = [];
  Result({super.key, @required reportData}) {
    this.reportData = reportData;
  }
  Container getStatistics() {
    var numberOfVocabs = 0;
    var numberOfCorrectGuess = 0;
    var numberOfIncorrectGuess = 0;
    var numberOfHintsUsed = 0;
    var totalScore = 0;

    numberOfVocabs = reportData.length;

    reportData.forEach((element) {
      numberOfCorrectGuess += element["correctGuess"] as int;
      numberOfIncorrectGuess += element["incorrectGuess"] as int;
      numberOfHintsUsed += element["isHintUsed"] ? 1 : 0;
      totalScore += element["score"] as int;
    });

    return Container(
        
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Correct Guess : ${numberOfCorrectGuess}",
            textScaleFactor: 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Incorrect Guess : ${numberOfIncorrectGuess}",
            textScaleFactor: 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Total Hint Taken : ${numberOfHintsUsed}",
            textScaleFactor: 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Total Score : ${totalScore}",
            textScaleFactor: 2,
          ),
        ),
      ]),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 32, 124, 35),
            Color.fromARGB(255, 185, 255, 104),
          ],
        ),
      ),
          child: Column(children: [
            SizedBox(
              height: 200,
              width: 200,
            ),
            getStatistics(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green[600])
                            ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Hangman()));
                  },
                  child: Text("Begin another game"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green[600])
                            ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text("Back to Home"),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
