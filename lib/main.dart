import 'package:flutter/material.dart';
import 'package:tarefas_app/screens/home_screen.dart';

void main(){
  runApp(MaterialApp(
    home: HomeScreen(),
    theme:  ThemeData(
      brightness: Brightness.dark,
      accentColor: Color.fromARGB(255, 71 ,148 ,87),
    ),
  debugShowCheckedModeBanner: false,
  )
);

}

