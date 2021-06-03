import 'package:flutter/material.dart';
import 'package:phase_1/ui/fifthScreen/fifth_screen.dart';
import 'package:phase_1/ui/first_screen.dart';
import 'package:phase_1/ui/fourthScreen/fourth_screen.dart';
import 'package:phase_1/ui/secondScreen/second_screen.dart';
import 'package:phase_1/ui/thirdScreen/third_screen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => FirstScreen(),
        '/secondscreen': (context) => SecondScreen(),
        '/thirdscreen': (context) => ThirdScreen(),
        '/fourthscreen': (context) => FourthScreen(),
        '/fifthscreen': (context) => FifthScreen()
      },
    );
  }
}
