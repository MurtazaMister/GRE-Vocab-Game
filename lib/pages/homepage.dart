import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _username=null;
    Future<String> checkLogin() async {
      dynamic id = await SessionManager().get("username");
      return id;
    }

    checkLogin().then((value) {
      if(value!=null){
        _username = value;
      }
    }).whenComplete(() => {
      if(_username==null){
        Navigator.pushNamed(context, "/login")
      }
    });

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("GRE Dictionary game"),

      ),
    );
  }
}
