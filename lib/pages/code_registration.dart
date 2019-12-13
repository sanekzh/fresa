import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';

import 'package:fresa/libra/pin_input_text_field.dart';


class CodeRegistrationPage extends StatefulWidget {
  String phone;
  String status;

  CodeRegistrationPage({Key key, this.phone, this.status}) : super(key: key);

  @override
  _CodeRegistrationPageState createState() => _CodeRegistrationPageState();
}

class _CodeRegistrationPageState extends State<CodeRegistrationPage> {
  @override

  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child:
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                  ),
                  Form(
                    key: this._formKey,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          PinInputTextField(
                            pinLength: 4,
//                            decoration: _pinDecoration,
//                            controller: _pinEditingController,
                            autoFocus: true,
                            textInputAction: TextInputAction.go,
                            onSubmit: (pin) {
                              debugPrint('submit pin:$pin');
                            },
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Codigo de SMS';
                                }
                              },
                              controller: _codeController,
                              onSaved: (value) => code = value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Codigo de SMS")),
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
                                      '${_codeController.text}');
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  requestLogIn(context, widget.phone, code);

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
              ),));
  }
}
