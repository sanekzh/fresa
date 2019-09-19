//import 'dart:_http';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:fresa/models/login_model.dart';

Future<LoginModel> requestLogoutAPI(BuildContext context) async {
  final url = "https://catapulto.ru/api/v1/users/api-token-auth/";

  var token;

  await getToken().then((result) {
    token = result;
  });

//  final response = await http.post(
//    url,
//    headers: {HttpHeaders.authorizationHeader: "Token $token"},
//  );
//
//  if (response.statusCode == 200) {
//    saveLogout();
//    return null;
//  } else {
//    saveLogout();
//    return null;
//  }
}