import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';

//import 'package:fresa/libra/pin_input_text_field.dart';

//import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';


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
        backgroundColor: Color.fromRGBO(254, 237, 235, 1),
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
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(90.0, 70.0, 90.0, 10.0),
                    child:  Center(
                      child: Image.asset('res/images/logo_m.png',),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
                  ),
                  Form(
                    key: this._formKey,
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[

                          Text('Codigo de SMS', style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold,
//                            fontFamily: 'Gilroy',
                            color: Color.fromRGBO(74, 54, 54, 1),
                          ),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(55.0, 0.0, 55.0, 30.0),
                            child: PinCodeTextField(
                              autofocus: false,
                              controller: _codeController,
                              hideCharacter: false,
                              highlight: true,
                              highlightColor: Colors.white,
                              defaultBorderColor: Colors.white,
                              hasTextBorderColor: Colors.white,
                              maxLength: 4,
                              onTextChanged: (text) {
                                setState(() {
                                  code = text;
                                });
                              },
                              onDone: (text){
                                print("DONE $text");
                                code = text;
                              },
                              wrapAlignment: WrapAlignment.start,
                              pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                              pinBoxHeight: 64,
                              pinBoxRadius: 8,
                              pinBoxColor: Colors.white,
                              pinBoxWidth: 50,
                              pinBoxBorderWidth: 0,
                              pinTextStyle: TextStyle(fontSize: 30.0),
                              pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: Container(
                                height: 64.0,
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
                                      print(code);
                                      print(_codeController.text);
                                      requestLogIn(context, widget.phone, _codeController.text);

                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(12.0),
//                                  side: BorderSide(color: Colors.red)
                                  ),
                                  child: Text("SIGUIENTE PASO",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
//                                    fontFamily: 'Gilroy',
                                          color: Colors.white, height: 1, fontSize: 18.0
                                      )
                                  ),
                                  color: Color.fromRGBO(195, 48, 48, 1),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),));
  }
}
