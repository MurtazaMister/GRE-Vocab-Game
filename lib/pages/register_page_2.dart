import "package:flutter/material.dart";

class RegisterPage2 extends StatefulWidget {
  var _firstname,_lastname;
  RegisterPage2({Key? key, @required firstname, @required lastname}) : super(key: key){
    _firstname = firstname;
    _lastname = lastname;
  }

  @override
  State<RegisterPage2> createState() => _RegisterPage2State(firstname: _firstname,lastname: _lastname);
}

class _RegisterPage2State extends State<RegisterPage2> {
  var _firstname,_lastname;
  _RegisterPage2State({@required firstname, @required lastname}){
    _firstname = firstname;
    _lastname = lastname;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Text(_firstname.text),
          Text(_lastname.text),
          Text("Welcome to my world")
        ],
      ),
    );
  }
}
