import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/pages/list_page.dart';
import 'package:http/http.dart' as http;
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:fresa/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:fresa/models/city.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class MainPage extends StatefulWidget {
  int selectedDrawerIndex;

  MainPage({Key key, this.selectedDrawerIndex = 1}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  City city_from, city_to;
  String _username = '';
  String _individualName = '';
  int _selectedDrawerIndex = 0;
  int max_limit = 10;
  String _ordering = '';

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token){
      print(token);
      pushTokenToServer(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
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
    loadUserNameData().then((value) {
      setState(() {
        _username = value != null ? value : '';
        _selectedDrawerIndex = _username != '' ? 0 : 1;
        if (_username != ''){
         Navigator.of(context).pushReplacementNamed('/list_new');
        }
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
        _selectedDrawerIndex = _username != '' ? 0 : 1;
      });
    });

  }
  void pushTokenToServer(token) async {
    var url_update = 'http://api.mermelando.es/api/customer/firebase/update/';
    Map<String, String> body_update = {
      'firebase_token': token,
    };
    var token_user;
    await getToken().then((result) {
      token_user = result;
    });
    print("FIREBASE UPDATE TOKEN - ${token_user}");
    Map<String, String> headerToken = {
      "X-Token": "Token ${token_user}"
    };
    final response = await http.put(
      url_update,
      headers: headerToken,
      body: body_update,
    );
    if(response.statusCode == 200){
      print('OK UPDATE');
      print(response.body);
    } else {
      print(response.body);
      print('ERROR UPDATE');
    }
  }
  void firebaseCloudMessaging_Listeners() {
//    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  Future<String> loadUserNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastUser');
  }

  Future<String> loadIndiviadualNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastIndividualName');
  }

  setData() {
    loadUserNameData().then((value) {
      setState(() {
        _username = value != null ? value : '';
        _selectedDrawerIndex = _username != null ? 0 : 1;
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
        _selectedDrawerIndex = _username != null ? 0 : 1;
      });
    });
  }

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  PhonePage() {
    return Container(
        padding: new EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            TextField(
//              obscureText: true,
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                border: OutlineInputBorder(),
                focusColor: Colors.redAccent,
                labelText: 'Enter your phone number',
              ),
            ),
            Container(height: 45.0,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  print('${_phoneNumberController.text}, ${_codeController.text}');
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  var s = requestLoginAPI(context, _phoneNumberController.text, _codeController.text);
                  print(s);
                },
                child: Text("GO",
                    style: TextStyle(color: Colors.white,
                        fontSize: 18.0)
                ),
                color: Colors.redAccent,
              ),
            )
          ],
        )


    );
  }

  WaitPage() {
    return Container(
        child: Center(
            child: CircularProgressIndicator()
        ),
    );
  }

//  AddressList() {
//    return Builder(builder: (BuildContext context) {
//      return new Container(
//        child: isLoading
//            ? Center(
//          child: CircularProgressIndicator(),
//        )
//            : new ListView.builder(
//          itemCount: list_company == null ? 0 : list_company.length,
//          itemBuilder: (BuildContext context, int index) {
//            return new Container(
//              child: new Center(
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    new Card(
//                      child: new Container(
//                        padding: new EdgeInsets.all(20.0),
//                        child: new Column(
//                          children: <Widget>[
//                            new Row(children: <Widget>[
//                              new Text(
//                                list_company[index].name,
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              new Text('  '),
//                              new Text(list_company[index].balance.toString(),
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold))
//                            ]),
//                          ],
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            );
//          },
//        ),
//      );
//    });
//  }

//  _getDrawerItemWidget(int pos) {
//    switch (pos) {
//      case 0:
//        return MainPage();
//      case 1:
//        return AddressList();
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: _username == '' ? PhonePage() : WaitPage()

    );
  }

}
