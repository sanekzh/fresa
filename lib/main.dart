import 'package:flutter/material.dart';

import 'package:fresa/pages/main_page.dart';
import 'package:fresa/pages/code_registration.dart';
import 'package:fresa/pages/list_offers.dart';
import 'package:fresa/pages/menu.dart';


ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.redAccent,
    primaryColor: Colors.redAccent,
  );
}


void main() => runApp(MaterialApp(
  theme: buildTheme(),
  initialRoute: '/',
  routes: {
    '/': (context) => MainHome(),
    '/code_registration' : (context) => CodeRegistrationPage(),
    '/list_offers': (context) => Offer(),
    '/menu': (context) => Menu(),

  },
));


