import 'package:fresa/bloc/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresa/common/apifunctions/requestLoginApi.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';


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
        backgroundColor: Colors.white,
        key: model.scaffoldKey,
        body: model.userName == ''
            ? Container(
            padding: new EdgeInsets.all(25.0),
            child: model.isLoading
                ? Align(
              child: Container(
                color: Colors.grey[300],
                width: 70.0,
                height: 70.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:
                    new Center(child: new CircularProgressIndicator())
                ),
              ),
              alignment: FractionalOffset.center,
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: model.formKey,
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
                            controller: model.phoneNumberController,
                            keyboardType: TextInputType.number,
                            onSaved: (value) => model.setPhone = value,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter your phone number"
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        ),
                        Container(
                          height: 45.0,
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
                            child: Text("GO",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0
                                )
                            ),
                            color: Colors.redAccent,
                          ),
                        )
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
