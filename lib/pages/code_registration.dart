import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/models/company.dart';
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




class CodeRegistrationPage extends StatefulWidget {
  String phone;

  CodeRegistrationPage({Key key, this.phone}) : super(key: key);

  @override
  _CodeRegistrationPageState createState() => _CodeRegistrationPageState();
}

class _CodeRegistrationPageState extends State<CodeRegistrationPage> {
  @override

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: new EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.redAccent)),
                  focusColor: Colors.redAccent,
                  labelText: 'Enter SMS code',
                ),
              ),
              Container(
                height: 45.0,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    print(
                        '${_phoneNumberController.text}, ${_codeController.text}');
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    requestLoginAPI(
                        context, widget.phone, _codeController.text);

                  },
                  child: Text("GO",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.redAccent,
                ),
              )
            ],
          )),
    );
  }
}
