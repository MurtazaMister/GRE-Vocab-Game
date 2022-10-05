import "package:flutter/material.dart";
import 'package:gre_dictionary_game/pages/homepage.dart';
import 'package:gre_dictionary_game/pages/register_page_1.dart';
import 'package:gre_dictionary_game/pages/register_page_2.dart';
import 'package:gre_dictionary_game/utils/routes.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/register/2",
      routes: {
        "/home":(context)=>HomePage(),
        "/register":(context)=>RegisterPage1(),
        "/register/1":(context)=>RegisterPage1(),
        "/register/2":(context)=>RegisterPage2(),
      },
    );
  }
}