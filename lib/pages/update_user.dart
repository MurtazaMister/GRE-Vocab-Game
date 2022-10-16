import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gre_dictionary_game/Services/firebase_crud.dart';
import 'package:gre_dictionary_game/Services/firebase_vocab.dart';

import '../utils/text_theme.dart';

class UpdateUser extends StatefulWidget {
    String? username, password, first_name, last_name,email;
   UpdateUser({Key? key, @required username, @required password, @required first_name, @required last_name, @required email}) : super(key: key){
      this.username = username;
      this.password = password;
      this.first_name = first_name;
      this.last_name = last_name;
      this.email = email;
   }

  @override
  State<UpdateUser> createState() => _UpdateUserState(username: username, password: password, first_name: first_name, last_name: last_name, email: email);
}

class _UpdateUserState extends State<UpdateUser> {

  _UpdateUserState({@required username, @required password, @required first_name, @required last_name, @required email}) {

    
    usernameC.text = username.toString();
    emailC.text = email.toString();
    passwordC.text = password.toString();
    first_nameC.text = first_name.toString();
    last_nameC.text = last_name.toString();

  }

  TextEditingController emailC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController first_nameC = TextEditingController();
  TextEditingController last_nameC = TextEditingController();

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    
   UpdateUserFunction(BuildContext context) async {

    await FirebaseCrud.updateUser(email: emailC.text,username: usernameC.text,password: passwordC.text,first_name: first_nameC.text, last_name:last_nameC.text);

    await SessionManager().set("username", usernameC.text);
    await SessionManager().set("first_name", first_nameC.text);
    await SessionManager().set("last_name", last_nameC.text);
    await SessionManager().set("email", emailC.text);
    await SessionManager().set("password", passwordC.text);

    setState(() {
      
    });
   }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        left: true,
        right: true,
        minimum: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: usernameC,
                enabled: false,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Username", labelText: "Username"
                ),
              ),

              TextFormField(
                controller: first_nameC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Update your first name", labelText: "First Name"
                ),
              ),

              TextFormField(
                // initialValue: synonyms1,
                controller: last_nameC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Update your last name", labelText: "Last Name"
                ),
              ),

              TextFormField(
                // initialValue: example1,
                controller: emailC,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Update your email", labelText: "Email"
                ),
              ),
              TextFormField(
                // initialValue: example1,
                controller: passwordC,
                obscureText: true,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "please enter a valid value";
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: "Update your password", labelText: "Password"
                ),
              ),

              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () => (UpdateUserFunction(context)),
                        // onPressed: () => (printVars()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                        child: Text(
                          "Update",
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