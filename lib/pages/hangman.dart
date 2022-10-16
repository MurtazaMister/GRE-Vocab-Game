import "package:flutter/material.dart";

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  @override
  Widget build(BuildContext context) {
    List<String> alphabets = [];
    for (int i = 0; i < 26; i++) {
      alphabets.add(String.fromCharCode(i + 65));
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

    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/hangman/step0.jpg'),
            Wrap(
              children: <FloatingActionButton>[
                ...getFloatingActionButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
