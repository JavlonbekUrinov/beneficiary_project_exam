import 'package:flutter/material.dart';

import 'pages/adding_page.dart';
import 'pages/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter beniciary",
      home: CardsPage(),
      routes: {
        CardsPage.id: (context) => CardsPage(),
        AddCardPage.id: (context) => AddCardPage(),
      },
    );
  }
}
