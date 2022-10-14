import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("GRE Dictionary game"),
      ),
    );
  }
}
