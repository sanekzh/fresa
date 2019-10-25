import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/pages/list_page.dart';
import 'package:http/http.dart' as http;
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  if (token_user != null){
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
}

class MainPage extends StatefulWidget {
  int selectedDrawerIndex;

  MainPage({Key key, this.selectedDrawerIndex = 1}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String _username = '', phone= '';
  String _individualName = '';
  int _selectedDrawerIndex = 0;
  int max_limit = 10;
  String _ordering = '';
  var isLoading = false;


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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  PhonePage() {
    return Container(
        padding: new EdgeInsets.all(25.0),
        child: isLoading
            ? Align(child: Container(
          color: Colors.grey[300],
          width: 70.0,
          height: 70.0,
          child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
        ),alignment: FractionalOffset.center,)
//        Center(
//          child: CircularProgressIndicator(),
//        )
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Form(
              key: this._formKey,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter phone';
                          }
                        },
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => phone = value,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter your phone number")),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    ),
                    Container(
                      height: 45.0,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 1.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            setState(() {
                              isLoading = true;
                            });
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            requestCheckPhone(context, _phoneNumberController.text);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Text("GO",
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0)),
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
//            TextField(
////              obscureText: true,
//              controller: _phoneNumberController,
//              keyboardType: TextInputType.number,
//              cursorColor: Colors.redAccent,
//              decoration: InputDecoration(
//
//                border: OutlineInputBorder(borderRadius: new BorderRadius.circular(0.0)),
//                focusColor: Colors.redAccent,
//                labelText: 'Enter your phone number',
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//            ),
//            Container(height: 45.0,
//              width: double.infinity,
//              child: RaisedButton(
//                onPressed: () {
//                  print('${_phoneNumberController.text}, ${_codeController.text}');
//                  SystemChannels.textInput.invokeMethod('TextInput.hide');
//                  print(" _phoneNumberController ${_phoneNumberController.text} ${_codeController.text} ");
//                  var s = requestCheckPhone(context, _phoneNumberController.text);
//                  print(s);
//                },
//                child: Text("GO",
//                    style: TextStyle(color: Colors.white,
//                        fontSize: 18.0)
//                ),
//                color: Colors.redAccent,
//              ),
//            )
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: _username == '' ? PhonePage() : WaitPage()

    );
  }

}
