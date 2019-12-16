import 'package:fresa/bloc/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';



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
                : Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(90.0, 70.0, 90.0, 10.0),
                  child:  Center(
                    child: Image.asset('res/images/logo_m.png',),
                  ),
                ),
                Form(
                  key: model.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 110.0, 10.0, 40.0),

                            child: TextFormField(

//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please enter phone';
//                                    }
//                                  },
                                  controller: model.phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) => model.setPhone = value,
                                  decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.symmetric(vertical: 22.0, horizontal: 10.0),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                        child:  new IconButton(
                                          icon: new SvgPicture.asset('res/images/phone_24px_rounded.svg',width: 23.0,height: 23.0,),
                                          onPressed: null,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),                                      hintText: 'Telefono',
                                      hintStyle: TextStyle(fontSize: 18,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w800,
//                                        fontFamily: 'Gilroy',
                                        color: Color.fromRGBO(74, 54, 54, 1),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70
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
                                if (model.formKey.currentState.validate()) {
                                  model.formKey.currentState.save();
                                  model.setIsLoading = true;
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  requestCheckPhone(
                                      context, model.phoneNumberController.text);
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
                                      letterSpacing: 1.5,
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
            ))
            : Container(
                child: Center(child: CircularProgressIndicator()),
              )
    );
  }
}
