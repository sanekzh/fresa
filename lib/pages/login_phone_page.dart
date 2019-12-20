import 'package:fresa/bloc/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';




class LoginPhone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: ScopedModelDescendant<MainModel>(builder: (context, child, model) {
        return LoginPhonePage(model: model);
      }),
    );
  }
}


class LoginPhonePage extends StatefulWidget {
  final MainModel model;

  LoginPhonePage({Key key, this.model }) : super(key: key);

  @override
  _LoginPhonePageState createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  var maskFormatter = new MaskTextInputFormatter(mask: '### ## ## ##', filter: { "#": RegExp(r'[0-9]') });

  @override
  void initState() {
    super.initState();
    widget.model.initFunc(context);
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = widget.model;
    return new Scaffold(
        backgroundColor: Color.fromRGBO(254, 237, 235, 1),
        key: model.scaffoldKey,
        body: model.userName == ''
            ? Container(
            padding: new EdgeInsets.all(25.0),
            child: model.isLoading
                ? Align(
              child: Container(
                color:Color.fromRGBO(254, 237, 235, 1),
                width: 70.0,
                height: 70.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:
                    new Center(child: Image.asset('res/images/logo_m.png',),)
                ),
              ),
              alignment: FractionalOffset.center,
            )
                :
            Container(
              child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(90.0, 70.0, 90.0, 10.0),
                child:  Center(
                  child: Image.asset('res/images/logo_m.png',width: 112, height: 107,),
                ),
              ),Flexible(child:  SingleChildScrollView(
                reverse: true,
                child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    Form(
                      key: model.formKey,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 145.0, 10.0, 30.0),

                              child: TextFormField(

//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please enter phone';
//                                    }
//                                  },
                                  inputFormatters: [maskFormatter],
                              autocorrect: false,
                                  onChanged: (text) {
//                                    if (text.length == 4){
////                                      model.phoneNumberController.text = '(34) ';
//                                      var cursorPos = model.phoneNumberController.selection;
//                                      setState(() {
//                                        model.phoneNumberController.text = '(34) ';
//print(cursorPos.end);
//                                        if (cursorPos.end > '(34) '.length) {
//                                          cursorPos = new TextSelection.fromPosition(
//                                              new TextPosition(offset: '(34) '.length));
//                                        }
////                                        cursorPos.start = 5;
//                                        model.phoneNumberController.selection = cursorPos;
//                                      });
//                                      model.phoneNumberController.value = model.phoneNumberController.value.copyWith(text: '(34) ', selection:TextSelection.fromPosition(
//                                          new TextPosition(offset: '(34) '.length)));
//
//                                    }
//                                    if (text.replaceAll(new RegExp(r"[^\d]|\s+\b|\b\s"), "").length == 11) {
//                                      FocusScope.of(context).requestFocus(FocusNode());
//                                    }
                                  },

                                  controller: model.phoneNumberController,
                                  keyboardType: TextInputType.number,
//                                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

                                  onSaved: (value) => model.setPhone = value,
                                  onTap: () {
//                                    if (model.phoneNumberController.text.length <= 5 ){
//                                      model.phoneNumberController.text = '(34) ';
//                                    }
                                    model.setErrorPhone = false;
                                  },

                                  style: TextStyle(fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w800,
//                                  color: Colors.grey,
//                                        fontFamily: 'Gilroy',
                                    color: Color.fromRGBO(87, 86, 86, 1),
                                  ),

                                cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: model.errorPhone ? Colors.redAccent : Colors.white),
                                      ),
                                      contentPadding: new EdgeInsets.symmetric(vertical: 22.0, horizontal: 10.0),
//                                      prefixIcon:
//                                      Padding(
//                                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                                        child: Image.asset('res/images/34.png', width: 23.0, height: 23.0,),
//                                      ),
                                      prefixIcon:
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 85,
                                            child: Row(children: <Widget>[
                                          IconButton(
                                            icon: new SvgPicture.asset('res/images/phone_24px_rounded.svg',width: 23.0,height: 23.0,),
                                            onPressed: null
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
                                            child: Text('(34) ', style: TextStyle(fontSize: 18,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w800,
//                                  color: Colors.grey,
                                              fontFamily: 'Gilroy',
                                              color: Color.fromRGBO(87, 86, 86, 1),
                                            ),),
                                          )

                                        ],)
                                        )

                                      ),
                                      focusColor: Colors.grey,
                                      border: OutlineInputBorder(

                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 0,
//                                          style: BoxBorder(
//                                           b
//                                          ),
                                        ),
                                      ),

//                                      labelText: 'Telefono',
                                      hintText: '000 00 00 00',
                                      hintStyle: TextStyle(fontSize: 18,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey,
//                                        fontFamily: 'Gilroy',
//                                        color: Color.fromRGBO(74, 54, 54, 1),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white
                                  )
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
                                      print(model.phoneNumberController.text.replaceAll(new RegExp(r"[^\d]|\s+\b|\b\s"), ""));
                                      if (model.formKey.currentState.validate()) {
                                        model.formKey.currentState.save();
                                        model.setIsLoading = true;

                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.hide');
                                        requestCheckPhone(
                                            context, '34' + model.phoneNumberController.text.replaceAll(new RegExp(r"[^\d]|\s+\b|\b\s"), ""),
                                        model);
                                        model.setIsLoading = false;
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
                ),),)

            ],),)

            )
            : Container(
                child: Center(child: CircularProgressIndicator()),
              )
    );
  }
}
