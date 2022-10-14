import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_crud.dart';
import '../utils/text_theme.dart';
import '../Services/firebase_crud.dart';

class RegisterPage2 extends StatefulWidget {
  var _firstname, _lastname;
  RegisterPage2({Key? key, @required firstname, @required lastname})
      : super(key: key) {
    _firstname = firstname;
    _lastname = lastname;
  }

  @override
  State<RegisterPage2> createState() =>
      _RegisterPage2State(firstname: _firstname, lastname: _lastname);
}

class _RegisterPage2State extends State<RegisterPage2> {
  var _firstname, _lastname;

  TextEditingController _email = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  addUserFunction(BuildContext context) {
    bool duplicate_user = FirebaseCrud.verifyUsername(_username.text);
    // if(duplicate_user)
  }

  _RegisterPage2State({@required firstname, @required lastname}) {
    _firstname = firstname;
    _lastname = lastname;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        left: true,
        right: true,
        minimum: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: _email,
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return "Invalid email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter your email", labelText: "Email"),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _username,
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return "Invalid username";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Select a username", labelText: "Username"),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _password,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return "Invalid password";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Select a password", labelText: "Password"),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => (addUserFunction(context)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  "Register Now",
                  style: AppTheme.defaultStyle().merge(TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
