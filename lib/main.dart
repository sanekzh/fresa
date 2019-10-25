import 'package:flutter/material.dart';

import 'package:fresa/pages/mainpage.dart';
import 'package:fresa/pages/code_registration.dart';
import 'package:fresa/pages/list_page.dart';
import 'package:fresa/pages/menu.dart';


ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.redAccent,
    primaryColor: Colors.redAccent,
//    inputDecorationTheme: InputDecorationTheme(
//      labelStyle: TextStyle(
//          color: Colors.black,
//          fontSize: 24.0
//      ),
//    ),
  );
}


void main() => runApp(MaterialApp(
  theme: buildTheme(),
  initialRoute: '/',
  routes: {
    '/': (context) => MainPage(),
    '/list' : (context) => CodeRegistrationPage(),
    '/list_new': (context) => NewListPage(),
    '/menu': (context) => MenuPage(),

  },
));


