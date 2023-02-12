import 'package:flutter/material.dart';
import 'welcome_screen.dart';


void main(){
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
