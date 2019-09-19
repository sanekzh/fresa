import 'dart:convert';

import 'package:fresa/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fresa/models/login_model.dart';



Future<String> saveCurrentLogin(Map responseJson, String phone) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var user;
  if ((responseJson != null && !responseJson.isEmpty)) {
    user = LoginModel.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  var token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).token : "";
  print(token);
  var firebase_token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).firebase_token : "";
  var pk = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userId : 0;
  print("SAVE ${token}");
  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastFirebaseToken', (firebase_token != null && firebase_token.length > 0) ? firebase_token : "");
  await preferences.setInt('LastUserId', (pk != null && pk > 0) ? pk : 0);
  await preferences.setString('LastPhone', (phone != null && phone.length > 0) ? phone : 0);
  
  return token;
}

saveCurrentUser(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var individualName = (responseJson != null && !responseJson.isEmpty) ? UserModel.fromJson(responseJson).individualName : "";


  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  await preferences.setString('LastIndividualName', (individualName != null && individualName.length > 0) ? utf8convert(individualName) : "");

}