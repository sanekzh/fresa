import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';

class CodeRegistrationPage extends StatefulWidget {
  String phone;
  String status;

  CodeRegistrationPage({Key key, this.phone, this.status}) : super(key: key);

  @override
  _CodeRegistrationPageState createState() => _CodeRegistrationPageState();
}

class _CodeRegistrationPageState extends State<CodeRegistrationPage> {
  @override
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registerPassController = TextEditingController();
  final TextEditingController _registerPassController2 =
      TextEditingController();
  String code = '', password = '', password2 = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
//        appBar: new AppBar(
//          iconTheme: IconThemeData(
//            color: Colors.black, //change your color here
//          ),
//          title: new Text(""),
//          backgroundColor: Colors.white,
//          elevation: 0.0,
//        ),
        body: Container(
            padding: new EdgeInsets.all(25.0),
            child: widget.status == 'new'
                ? Center(child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.phone}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                  ),
                  Form(
                    key: this._formKey,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter SMS code';
                                }
                              },
                              controller: _codeController,
                              onSaved: (value) => code = value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter SMS code")),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Set password:',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }
                              },
                              controller: _registerPassController,
                              onSaved: (value) => password = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password")),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  if (value !=
                                      _registerPassController.text) {
                                    return 'The two password fields didn\'t match.';
                                  }
                                }
                              },
                              controller: _registerPassController2,
                              onSaved: (value) => password2 = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password confirmation")),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          ),
                          Container(
                            height: 45.0,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 1.0),
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  print('OK!!!!!!!');
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  print(
                                      '${_phoneNumberController.text}, ${_codeController.text}');
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  requestPasswordSet(
                                      context, widget.phone, code, password,
                                      password2: password2);
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
                ],
              ),))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.phone}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                      ),
                      Form(
                        key: this._formKey,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                  },
                                  controller: _registerPassController,
                                  onSaved: (value) => password = value,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Password")),
                              Padding(
                                padding:
                                EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                              ),

                              Container(
                                height: 45.0,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 1.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      print('OK!!!!!!!');
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                      print(
                                          '${_phoneNumberController.text}, ${_codeController.text}');
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');

                                      requestLogIn(
                                          context, widget.phone, password);
                                    }
                                  },
                                  child: Text("GO",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                  color: Colors.redAccent,
                                ),
                              )
//                      RaisedButton(
//                        child: Text("Зарегистрироваться",
//                            style: TextStyle(color: Colors.white,
//                                fontSize: 18.0)
//                        ),
//                        color: Colors.blue,
//                        onPressed: () {
//                          if (_formKey.currentState.validate()) {
//                            _formKey.currentState.save();
//                            print('OK!!!!!!!');
//                            SystemChannels.textInput.invokeMethod('TextInput.hide');
//
//                          }
//                        },
//                      )
                            ],
                          ),
                        ),
                      ),
//                      TextField(
//                        obscureText: true,
//                        controller: _passwordController,
//                        cursorColor: Colors.redAccent,
//                        decoration: InputDecoration(
//                          border: OutlineInputBorder(
//                              borderRadius: new BorderRadius.circular(0.0)),
//                          focusColor: Colors.redAccent,
//                          labelText: 'Enter your password',
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//                      ),
//                      Container(
//                        height: 45.0,
//                        width: double.infinity,
//                        margin: const EdgeInsets.only(bottom: 1.0),
//                        child: RaisedButton(
//                          onPressed: () {
//                            requestLoginAPI(
//                                context, widget.phone, code, password,
//                                password2: password2);
//                          },
//                          child: Text("GO",
//                              style: TextStyle(
//                                  color: Colors.white, fontSize: 18.0)),
//                          color: Colors.redAccent,
//                        ),
//                      )
                    ],
                  )

            //              Container(
//                height: 45.0,
//                width: double.infinity,
//                child: RaisedButton(
//                  onPressed: () {
//                    print(
//                        '${_phoneNumberController.text}, ${_codeController.text}');
//                    SystemChannels.textInput.invokeMethod('TextInput.hide');
//                    requestLoginAPI(
//                        context, widget.phone, _codeController.text, '');
//
//                  },
//                  child: Text("GO",
//                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
//                  color: Colors.redAccent,
//                ),
//              )),
            ));
  }
}
