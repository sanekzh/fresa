import 'dart:async';

import 'package:fresa/common/functions/getToken.dart';
import 'package:flutter/material.dart';
import 'package:fresa/models/company.dart';
import 'package:fresa/pages/code_registration.dart';
import 'package:fresa/pages/list_offers.dart';
import 'package:http/http.dart' as http;
import 'package:fresa/common/functions/saveCurrentLogin.dart';
import 'package:fresa/common/functions/showDialogSingleButton.dart';
import 'dart:convert';


Future<List<dynamic>> fetchCompanyData() async {
  List<Company> list_company = List();

  var token;
  await getToken().then((result) {
    token = result;
  });
  print("fentch company ${token}");

  print("fetchStreetData - ${token}");
  String url = "http://api.mermelando.es/api/customer/companies/list/";
  Map<String, String> headerToken = {
    "Content-type": "application/json",
    "X-Token": "Token ${token}"
  };
  final response_company = await http.get(url, headers: headerToken);
  print(json.decode(response_company.body)['results'] as List);
  if (response_company.statusCode == 200) {
    print(response_company.body);
    list_company = (json.decode(response_company.body)['results'] as List)
        .map((data) => new Company.fromJson(data))
        .toList();
    return list_company;
  } else {
    throw Exception('Failed to load company');
  }
}

requestPasswordSet(
    BuildContext context, String phone, String code, String password,
    {String password2}) async {
  final url_authorize = "http://api.mermelando.es/api/customer/authorize/";

  final url_password_set =
      "http://api.mermelando.es/api/customer/password_set/";

  Map<String, String> body_authorize = {
    "phone": phone,
    "code": code,
    "password": password,
    "password2": password2
  };
  final response = await http.post(
    url_authorize,
    body: body_authorize,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('OK with code ${response.body}');
    final responseJson = json.decode(response.body);

    print(responseJson);
    saveCurrentLogin(responseJson, phone);
    if (responseJson['token'] != '') {
      print("111 password: ${password}   password2: ${password2}");
      final response_put = await http.put(
        url_password_set,
        headers: {"X-Token": "Token ${responseJson['token']}"},
        body: {"password": password, "password2": password2},
      );
      print(response.body);
      final response_put_Json = json.decode(response.body);
      if (response_put_Json['token'] != '') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Offer(token_t: responseJson['token'])),
              (Route<dynamic> route) => false,
        );
        Navigator.of(context).pushReplacementNamed('/list_offers');
      }
    }
  } else {
    final responseJson = json.decode(response.body);
    print('NO with code ${response.body}');
    showDialogSingleButton(
        context, "Error autorization", "${responseJson['error']}", "OK");
    return null;
  }
}

requestLogIn(BuildContext context, String phone, String password,) async {
  final url_authorize = "http://api.mermelando.es/api/customer/authorize/";
  final body_authorize = {"phone": phone, "password": password};
  print("sxcfsdfc");
  final response = await http.post(
    url_authorize,
    body: body_authorize,
  );
  print(response.body);
  final responseJson = json.decode(response.body);
  if (response.statusCode == 200) {
    saveCurrentLogin(responseJson, phone);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Offer(token_t: responseJson['token'])),
            (Route<dynamic> route) => false,
          );
  }else{
//        saveCurrentLogin(responseJson);
    print(responseJson);
    Map dict = json.decode(response.body)['error'];
          String text = '';
          if (dict.containsKey('password')){
            text = dict['password'];
          } else if (dict.containsKey('name')){
            text = dict['name'];
          } else if (dict.containsKey('detail')){
            text = dict['detail'];
          } else if (dict.containsKey('phone')){
            text = dict['phone'];
          }
    showDialogSingleButton(
        context, "Error autorization", "${text}", "OK");

  }

  return true;

}

requestCheckPhone(BuildContext context, String phone) async {
  final url_authorization =
      "http://api.mermelando.es/api/customer/authorization/";
  Map<String, String> body_authorization = {
    "phone": phone,
  };
  final response = await http.post(
    url_authorization,
    body: body_authorization,
  );
  if (response.statusCode == 200) {
    print('OK ${response.body}');
    final responseJson = json.decode(response.body);
    print(responseJson);
    if (responseJson['status'] == 'new') {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new CodeRegistrationPage(
            phone: phone, status: responseJson['status']),
      );
      Navigator.of(context).push(route);
    } else if (responseJson['status'] == 'exist') {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new CodeRegistrationPage(
            phone: phone, status: responseJson['status']),
      );
      Navigator.of(context).push(route);
    }
  } else {
    final responseJson = json.decode(response.body);
//        saveCurrentLogin(responseJson);
    print(responseJson);
    showDialogSingleButton(
        context, "Error autorization", "${responseJson['error']}", "OK");
    return null;
  }
}
