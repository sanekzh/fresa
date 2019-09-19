import 'dart:async';

import 'package:fresa/common/functions/getToken.dart';
import 'package:flutter/material.dart';
import 'package:fresa/models/company.dart';
import 'package:fresa/pages/code_registration.dart';
import 'package:fresa/pages/mainpage.dart';
import 'package:fresa/pages/list_page.dart';
import 'package:http/http.dart' as http;
import 'package:fresa/common/functions/saveCurrentLogin.dart';
import 'package:fresa/common/functions/showDialogSingleButton.dart';
import 'dart:convert';

import 'package:fresa/models/login_model.dart';


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
  final response_company =
  await http.get(url, headers: headerToken);
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

requestLoginAPI(BuildContext context, String phone, String code) async {
  final url_authorization = "http://api.mermelando.es/api/customer/authorization/";
  final url_authorize = "http://api.mermelando.es/api/customer/authorize/";

  Map<String, String> body_authorization = {
    'phone': phone,
  };

  Map<String, String> body_authorize = {
    'phone': phone,
    'code': code
  };
  print(phone);
  print(code);
  if (phone != '' && code == ''){
      final response = await http.post(
        url_authorization,
        body: body_authorization,
      );
      if(response.statusCode == 200){
        print('OK ${response.body}');
        final responseJson = json.decode(response.body);
//        var token = saveCurrentLogin(responseJson, phone);
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new CodeRegistrationPage(phone: phone),
        );
        Navigator.of(context).push(route);
      }
      else {
        final responseJson = json.decode(response.body);
//        saveCurrentLogin(responseJson);
        showDialogSingleButton(context, "Error autorization", "${responseJson['error']}", "OK");
        return null;
      }
  }
  else if (phone != '' && code != ''){
    final response = await http.post(
      url_authorize,
      body: body_authorize,
    );
    if(response.statusCode == 200){
      print('OK with code ${response.body}');
      final responseJson = json.decode(response.body);
      saveCurrentLogin(responseJson, phone);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NewListPage()),
            (Route<dynamic> route) => false,
      );
//      Navigator.of(context).pushReplacementNamed('/list_new');
    }
    else {
      final responseJson = json.decode(response.body);
      print('NO with code ${response.body}');
//      saveCurrentLogin(responseJson);
      showDialogSingleButton(context, "Error autorization", "${responseJson['error']}", "OK");
      return null;
    }
  }

//
//  if (response.statusCode == 200) {
//    final responseJson = json.decode(response.body);
//    var user = new LoginModel.fromJson(responseJson);
//    print(responseJson);
//    var token;
//    await saveCurrentLogin(responseJson).then((result){
//      token = result;
//    });
//
//    print("TOKEN - ${token}");
//    Map<String, String> headers_2 = {
//      "Content-type": "application/json",
//      "X-Token": "Token ${token}"
//    };
//
//    http.Response response_2 = await http.get(
//      url_get_user,
//      headers: headers_2,
//    );
//    String utf8convert(String text) {
//      List<int> bytes = text.toString().codeUnits;
//      return utf8.decode(bytes);
//    }
//    print(utf8convert(json.decode(response_2.body)['detail']));
//    if (response_2.statusCode == 200) {
//      final responseJson = json.decode(response_2.body);
//      print(responseJson);
//      saveCurrentUser(responseJson);
//    }
//
//    Navigator.of(context).pushReplacementNamed('/');
//
//    return LoginModel.fromJson(responseJson);
//  } else {
//    final responseJson = json.decode(response.body);
//    saveCurrentLogin(responseJson);
//    showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.", "OK");
//    return null;
//  }
}