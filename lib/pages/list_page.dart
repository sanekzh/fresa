import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/pages/mainpage.dart';
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
import 'package:fresa/models/company.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class NewListPage extends StatefulWidget {

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {

  City city_from, city_to;
  String _username = '';
  String _individualName = '';
  String _token = '';
  List<Company> list_company = List();
  var isLoading = false;
//  int _selectedDrawerIndex = 0;
  int max_limit = 10;
  String _ordering = '';

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



  @override
  void initState() {
    super.initState();
    this.fetchCompanyData();
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
    loadUserNameData().then((value) {
      setState(() {
        _username = value != null ? value : '';
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
      });
    });
//    getToken().then((result) {
////      token_user = result;
//      _fetchCompanyData(result);
//    });

    loadTokenData().then((value) {
      setState(() {
        _token = value != null ? value : '';
      print("!!!!!${_token}");
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


  Future<String> fetchCompanyData() async {

    setState(() {
      isLoading = true;
    });
    var token;
    getToken().then((result) {
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
      if (list_company.length >= 1) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load company');
    }
    return "Success";
  }

  Future<String> loadTokenData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastToken');
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
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,

      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text(_username != '' ? '${_username}' : ''),
        actions: <Widget>[
          _username == ''
              ?
          Text('')
              :
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
              saveLogout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
                    (Route<dynamic> route) => false,
              );
              setState(() {
                _username = '';
                _individualName = '';
              });
            },
          ),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return new Container(
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : new ListView.builder(
            itemCount: list_company == null ? 0 : list_company.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                child: new Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          padding: new EdgeInsets.all(20.0),
                          child: new Column(
                            children: <Widget>[
                              new Row(children: <Widget>[
                                new Text(
                                  list_company[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                new Text('  '),
                                new Text(list_company[index].balance.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
