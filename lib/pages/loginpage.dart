import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gre_dictionary_game/Services/firebase_crud.dart';
import 'package:gre_dictionary_game/pages/register_page_1.dart';

import '../utils/text_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  final errorIcon = Icons.info_outline;
  final _errorText = "Username and password do not match";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  loginUser(BuildContext context) async {
    if (username.text.trim().length >= 3 &&
        password.text.trim().length >= 6 ) {
        Map<String,dynamic> user= await FirebaseCrud.verifyUser(username.text, password.text);
        if(user["isValid"]){
          await SessionManager().set("username", user["username"]);
          await SessionManager().set("first_name", user["first_name"]);
          await SessionManager().set("last_name", user["last_name"]);
          await SessionManager().set("email", user["email"]);
          await SessionManager().set("password", password.text.trim());
          Navigator.pushNamed(context, "/home");
        }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.green[100],
        content: Container(
          child: Row(
            children: [
              Icon(
                errorIcon,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(_errorText, style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brace yourselves",
                  style: AppTheme.defaultStyle().merge(TextStyle(
                    fontSize: 40,
                  ))),
              Text(
                "Boost up your vocabs while you play",
                style: AppTheme.defaultStyle().merge(TextStyle(fontSize: 19)),
              ),
              Text(
                "Register now",
                style: AppTheme.defaultStyle().merge(TextStyle(fontSize: 53)),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    hintText: "Enter your username",
                    labelText: "Username",
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      onPressed: () => {loginUser(context)},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size(150, 45),
                      ),
                      child: Text(
                        "Login",
                        style: AppTheme.defaultStyle().merge(TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Center(child: Text("Don't have an account with us?")),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        
                        
                        
                        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPage1(
                  )));},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size(150, 45),
                      ),
                      child: Text(
                        "Register now",
                        style: AppTheme.defaultStyle().merge(TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        )),
                      ),
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
