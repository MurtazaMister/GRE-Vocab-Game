import "package:flutter/material.dart";

class RegisterPage2 extends StatelessWidget {
  const RegisterPage2({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text("Username"),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Choose a username",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
