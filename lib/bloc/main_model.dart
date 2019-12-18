import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fresa/resources/repository.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class MainModel extends Model {
  final _repository = Repository();

  String _phone = '';
  get phone => _phone;
  set setPhone(String str){
    _phone = str;
    notifyListeners();
  }

  bool _isLoading = false;
  get isLoading => _isLoading;
  set setIsLoading(bool load){
    _isLoading = load;
    notifyListeners();
  }

  bool _errorCode = false;
  get errorCode => _errorCode;
  set setErrorCode(bool load){
    _errorCode = load;
    notifyListeners();
  }

  bool _errorPhone = false;
  get errorPhone => _errorPhone;
  set setErrorPhone(bool load){
    _errorPhone = load;
    notifyListeners();
  }

  String _username = '';
  get userName => _username;
  set setUserName(String str){
    _username = str;
    notifyListeners();
  }



//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController phoneNumberController = new MaskedTextController(mask: '(00) 000 00 00 00');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void initFunc(context) {
    loadUserNameData().then((value) {


      _username = value != null ? value : '';
      if (_username != '') {
        Navigator.of(context).pushReplacementNamed('/list_offers');
      }
      notifyListeners();
    });
//    _firebaseMessaging.getToken().then((token) {
//      print(token);
//      _repository.pushToken(token);
//    });
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        _messageText = "Push Messaging message: $message";
//        notifyListeners();
//        print("onMessage: $message");
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        _messageText = "Push Messaging message: $message";
//        notifyListeners();
//        print("onLaunch: $message");
//      },
//      onResume: (Map<String, dynamic> message) async {
//        _messageText = "Push Messaging message: $message";
//        notifyListeners();
//        print("onResume: $message");
//      },
//    );
//    _firebaseMessaging.requestNotificationPermissions(
//        const IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//    _firebaseMessaging.getToken().then((String token) {
//      assert(token != null);
//      _homeScreenText = "Push Messaging token: $token";
//      notifyListeners();
//      print(_homeScreenText);
//    });
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//      },
//    );
//    firebaseCloudMessaging_Listeners();

    loadIndiviadualNameData().then((value) {
      notifyListeners();
    });
  }

//  void firebaseCloudMessaging_Listeners() {
//    _firebaseMessaging.getToken().then((token) {
//      print(token);
//    });
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//      },
//    );
//  }
//
//  void iOS_Permission() {
//    _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//  }

  Future<String> loadUserNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastUser');
  }

  Future<String> loadIndiviadualNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastIndividualName');
  }
}

MainModel mainModel = MainModel();
