import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gre_dictionary_game/pages/homepage.dart';
import '../utils/text_theme.dart';
import '../Services/firebase_crud.dart';

class RegisterPage2 extends StatefulWidget {
  var _firstname, _lastname; // firstname and lastname received from previous page - registration_page_1

  /// Constructor of the stateful widget - RegisterPage2 which accepts the values taken from the user on the previous page of registration - [firstname] and [lastname]
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
  String? usernameError;

  TextEditingController _email = TextEditingController(); // Email control field
  TextEditingController _username = TextEditingController(); // username control field
  TextEditingController _password = TextEditingController(); // Password control field

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A key associated with the form to perform validation

  /// Adds the user initialized with all the details filled in the registration form into the Database and also adds these details to the current user session
  addUserFunction(BuildContext context) async {
    setState(() {
      usernameError = null;
    });
    if (_formKey.currentState!.validate()) {
      bool isInvalid = await FirebaseCrud.verifyUsername(_username.text);

      if (!isInvalid) {
        await FirebaseCrud.addUser(
            first_name: _firstname.text,
            last_name: _lastname.text,
            username: _username.text,
            password: _password.text,
            email: _email.text);

        await SessionManager().set("username", _username.text);
        await SessionManager().set("first_name", _firstname.text);
        await SessionManager().set("last_name", _lastname.text);
        await SessionManager().set("email", _email.text);
        await SessionManager().set("password", _password.text);

        Navigator.pushNamed(context, "/home"); // redirecting the user to home page once he/she has successfully registered
      } else {
        setState(() {
          usernameError = "Username already taken"; // If the username is already taken, then the user won't be able to move further
        });
      }
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextFormField(
                  controller: _email,
                  validator: (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (value == null ||
                        value.isEmpty ||
                        !regex.hasMatch(value))
                      return 'Enter a valid email address';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    labelText: "Email",
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _username,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Username too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Select a username",
                    labelText: "Username",
                    errorText: usernameError,
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  validator: (value) {
                    if (value!.trim().length < 6) {
                      return "Password too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Select a password", labelText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
