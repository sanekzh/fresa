import 'package:flutter/material.dart';

import 'package:fresa/pages/login_phone_page.dart';
import 'package:fresa/pages/code_registration.dart';
import 'package:fresa/pages/list_offers.dart';
import 'package:fresa/pages/menu.dart';

ThemeData buildTheme() {
  final ThemeData base = ThemeData(fontFamily: 'Gilroy');
  return base.copyWith(
    hintColor: Colors.redAccent,
    primaryColor: Colors.redAccent,
    canvasColor: Colors.transparent,
  );
}

void main() async {
  return runApp(MermelandoApp());
}

class MermelandoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: buildTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPhone(),
          '/code_registration': (context) => CodeRegistrationPage(),
          '/list_offers': (context) => Offer(),
          '/menu': (context) => Menu(),
        },
      ),
    );
  }
}
