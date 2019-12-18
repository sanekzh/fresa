import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/bloc/main_model.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';

//import 'package:fresa/libra/pin_input_text_field.dart';

//import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:scoped_model/scoped_model.dart';

class CodeRegistration extends StatelessWidget {
  String phone;
  String status;
  MainModel model;
  CodeRegistration({Key key, this.phone, this.status, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: ScopedModelDescendant<MainModel>(builder: (context, child, model) {
        return CodeRegistrationPage(model: model, phone: phone, status: status,);
      }),
    );
  }
}

class CodeRegistrationPage extends StatefulWidget {
  String phone;
  String status;
  MainModel model;
  CodeRegistrationPage({Key key, this.phone, this.status, this.model}) : super(key: key);

  @override
  _CodeRegistrationPageState createState() => _CodeRegistrationPageState();
}

class _CodeRegistrationPageState extends State<CodeRegistrationPage> {
  @override

  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String code = '', password = '', password2 = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showErrorSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: Duration(milliseconds: 950),

      content: Text(message),
      backgroundColor: Colors.redAccent,)
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget pinBox = PinCodeTextField(
      autofocus: true,
      controller: _codeController,
      hideCharacter: false,
      highlight: true,
      highlightColor:  Color.fromRGBO(135, 135, 135, 1),
      defaultBorderColor: Colors.white,
      hasTextBorderColor: widget.model.errorCode ? Colors.redAccent : Colors.white,
      maxLength: 4,
      onTextChanged: (text) {
        setState(() {
          code = text;
          if(text == '') {
            widget.model.setErrorCode = false;
          }
        });
      },
      onDone: (text){
        print("DONE $text");
        code = text;
        widget.model.setErrorCode = false;
      },
      wrapAlignment: WrapAlignment.center,
      pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinBoxHeight: 64,
      pinBoxRadius: 8,
      pinBoxColor: Colors.white,
      pinBoxWidth: 50,
      pinBoxBorderWidth: 2,
      pinTextStyle: TextStyle(fontSize: 30.0, color:  Color.fromRGBO(87, 86, 86, 1),),
      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
    );


    return new Scaffold(
        key: _scaffoldKey,
//        resizeToAvoidBottomPadding: false,
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
          child:  Container(child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(90.0, 70.0, 90.0, 10.0),
                child:  Center(
                  child: Image.asset('res/images/logo_m.png',),
                ),
              ),Flexible(child:  SingleChildScrollView(
                reverse: true,
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Form(
                      key: this._formKey,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
//                          mainAxisSize: MainAxisSize.max,
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 110.0, 0.0, 10.0),
                              child: Text('Codigo de SMS', style: TextStyle(fontSize: 24,
                                fontWeight: FontWeight.bold,
//                            fontFamily: 'Gilroy',

                                color: Color.fromRGBO(74, 54, 54, 1),
                              ),),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                              child: pinBox,
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

                                        requestLogIn(context, widget.phone, _codeController.text, widget.model);


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
                                            letterSpacing: 0,
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
                ),))]))
          )

    );
  }
}
