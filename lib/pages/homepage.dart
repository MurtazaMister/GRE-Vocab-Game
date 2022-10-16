import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gre_dictionary_game/pages/hangman.dart';
import 'package:gre_dictionary_game/pages/update_user.dart';
import 'package:gre_dictionary_game/pages/view_all_vocabs.dart';

import '../utils/text_theme.dart';

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
      appBar: AppBar(
        title: Text("GRE Dictionary game"),
        actions: [
          FloatingActionButton(onPressed: () async {

            String username = await SessionManager().get("username");
            String email = await SessionManager().get("email");
            String password = await SessionManager().get("password").toString();
            String first_name = await SessionManager().get("first_name");
            String last_name = await SessionManager().get("last_name");

            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateUser(username: username, password: password, first_name: first_name, last_name: last_name, email: email)));
          },
          elevation: 0,
          child: Icon(Icons.face),)
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome",style: AppTheme.defaultStyle().merge(TextStyle(
                      fontSize: 40,
                    )),),
              Text("to the",style: AppTheme.defaultStyle().merge(TextStyle(
                      fontSize: 30,
                    )),),
                    SizedBox(height: 20,),
              Text("GRE Vocab Dictionary",style: AppTheme.defaultStyle().merge(TextStyle(
                      fontSize: 30,
                    )),),
              Text("or a Game?",style: AppTheme.defaultStyle().merge(TextStyle(
                      fontSize: 30,
                    )),),
              Text("or Both!",style: AppTheme.defaultStyle().merge(TextStyle(
                      fontSize: 30,
                    )),),
              SizedBox(height: 100,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () => {Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewVocabs(
                  )))},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size(150, 45),
                      ),
                      child: Text(
                        "Practice vocabs",
                        style: AppTheme.defaultStyle().merge(TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () => {Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Hangman(
                  )))},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size(150, 45),
                      ),
                      child: Text(
                        "Test your- vocabs",
                        style: AppTheme.defaultStyle().merge(TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
