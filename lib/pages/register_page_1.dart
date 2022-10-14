import "package:flutter/material.dart";
import 'package:gre_dictionary_game/Services/firebase_crud.dart';
import 'package:gre_dictionary_game/pages/register_page_2.dart';
import '../utils/routes.dart';
import '../utils/textt_heme.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({Key? key}) : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  // final _formkey = GlobalKey<FormState>();

  final first_name = TextEditingController();
  final last_name = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  moveToRegisterPage2(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage2(firstname: first_name, lastname: last_name,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brace yourselves", style: AppTheme.defaultStyle().merge(TextStyle(
                fontSize: 40,
              ))),
              Text("Boost up your vocabs while you play", style: AppTheme.defaultStyle().merge(TextStyle(
                  fontSize: 19
              )),),
              Text("Register now", style: AppTheme.defaultStyle().merge(
                  TextStyle(
                      fontSize: 53
                  )
              ),),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: first_name,
                  validator: (value){
                    if(value!.isEmpty || value.length<2){
                      return "Invalid value for first name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your first name",
                      labelText: "First Name"
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: last_name,
                  validator: (value){
                    if(value!.isEmpty || value.length<2){
                      return "Invalid value for last name";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your last name",
                      labelText: "Last Name"
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: ()=>(moveToRegisterPage2(context)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: Text("Register Now", style: AppTheme.defaultStyle().merge(
                      TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                      )
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

