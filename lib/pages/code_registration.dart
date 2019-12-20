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
import 'package:pin_view/pin_view.dart';


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

  String new_code = '', password = '', password2 = '';
bool check = false, first_start = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showErrorSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: Duration(milliseconds: 950),

      content: Text(message),
      backgroundColor: Colors.redAccent,)
    );
  }
  @override
  void initState() {
    super.initState();
    first_start = true;
    widget.model.initFuncCode(context);
  }

  @override
  Widget build(BuildContext context) {


  Widget pinBox = TextFormField(

//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please enter phone';
//                                    }
//                                  },
      onChanged: (text) {
        print(text);

        widget.model.setErrorCode = false;
        if(text.length == 4 && new_code != '' && check == false){
          FocusScope.of(context).requestFocus(FocusNode());

          check =true;
          if (first_start){
            first_start = false;
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              print('OK!!!!!!!');
              SystemChannels.textInput
                  .invokeMethod('TextInput.hide');
              print(
                  '${widget.model.codeController.text}');
              SystemChannels.textInput
                  .invokeMethod('TextInput.hide');
              print(new_code);
              print(widget.model.codeController.text);

              requestLogIn(context, widget.phone, widget.model.codeController.text, widget.model);


            }
          }
        }
        if (text.length < 4){
          check = false;
        }
                new_code = text;
//        print(widget.model.codeController.text);
      },
      autofocus: true,
      maxLength: 4,
      controller: widget.model.codeController,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      onSaved: (value) => widget.model.setCode = value,
      onTap: () {
        if(widget.model.code != new_code){
          widget.model.setErrorCode = false;

        }
      },

      style: TextStyle(fontSize: 20,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w800,
//                                  color: Colors.grey,
                                        fontFamily: 'Gilroy',
        color: Color.fromRGBO(87, 86, 86, 1),
      ),
//textAlign: TextAlign.center,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          counterText: '',
//          alignLabelWithHint: true,
//          contentPadding: EdgeInsets.zero,
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                width: 2,
                color: widget.model.errorCode ? Colors.redAccent : Colors.white),
          ),
          contentPadding: new EdgeInsets.fromLTRB(35,16,20,16),
//          prefixIcon: Padding(
//            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//            child:  new IconButton(
//              icon: new SvgPicture.asset('res/images/phone_24px_rounded.svg',width: 23.0,height: 23.0,),
//              onPressed: null,
//            ),
//          ),
          focusColor: Colors.grey,
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
//                                          style: BoxBorder(
//                                           b
//                                          ),
            ),
          ),

//                                      labelText: 'Telefono',
          hintText: '0000',
          hintStyle: TextStyle(
            fontSize: 18,
            letterSpacing: 1,

            fontWeight: FontWeight.w800,
            color: Colors.grey,
                                        fontFamily: 'Gilroy',
//                                        color: Color.fromRGBO(74, 54, 54, 1),
          ),
          filled: true,
          fillColor: Colors.white
      )
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
                  child: Image.asset('res/images/logo_m.png',width: 112, height: 107,),
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
                        padding: EdgeInsets.all(8.0),
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

                            Container(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
                                child:  pinBox
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
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        print('OK!!!!!!!');
                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.hide');
                                        print(
                                            '${widget.model.codeController.text}');
                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.hide');
                                        print(new_code);
                                        print(widget.model.codeController.text);

                                        requestLogIn(context, widget.phone, widget.model.codeController.text, widget.model);


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
                                            letterSpacing: 1,
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
