import 'package:fresa/bloc/offers_model.dart';
import 'package:fresa/models/company.dart';
import 'package:fresa/pages/login_phone_page.dart';
import 'package:fresa/pages/menu.dart';
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';


class Offer extends StatelessWidget {
  final String token_t;

  Offer({Key key, this.token_t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<OfferModel>(
      model: offerModel,
      child:
          ScopedModelDescendant<OfferModel>(builder: (context, child, model) {
        return ListOffersPage(model: model, token_t: token_t);
      }),
    );
  }
}

class ListOffersPage extends StatefulWidget {
  final String token_t;
  final OfferModel model;

  ListOffersPage({Key key, this.token_t, this.model}) : super(key: key);

  @override
  _ListOffersPageState createState() => _ListOffersPageState();
}

class _ListOffersPageState extends State<ListOffersPage> {
  @override
  void initState() {
    super.initState();
    widget.model.initFunc(context);
  }

  List<Widget> _buildRowList(offers) {
    List<Widget> lines = [];
    print(offers);
    lines.add(
      Row(children: <Widget>[
        new Text('My special offers:',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
    lines.add(
      Padding(
        child: Container(
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      ),
    );
    for (var offer in offers) {
      lines.add(
        new Row(
          children: <Widget>[
            Icon(
              Icons.blur_circular,
              color: Colors.blue,
              size: 15.0,
            ),
            new Text('   '),
            new Text(offer['name']),
          ],
        ),
      );
    }
    lines.add(
      Padding(
        child: Container(
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      ),
    );
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    OfferModel model = widget.model;
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          title: new Text(model.userName != '' ? '${model.userName}' : ''),
          actions: <Widget>[
            model.userName == ''
                ? Text('')
                : IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    tooltip: 'Logout',
                    onPressed: () {
                      saveLogout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPhone()),
                        (Route<dynamic> route) => false,
                      );
                      model.setUserName = '';
                    },
                  ),
          ],
        ),
        body: FutureBuilder<List<Company>>(
            future: model.listCompany,
            builder: (_, AsyncSnapshot<List<Company>> snapshot) {
              var listCompany = snapshot.data;
              if (snapshot.hasData) {
                return Container(
                    child: new ListView.builder(
                  itemCount: listCompany.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      child: new Center(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Card(
                              elevation: 10,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: new Container(
                                padding: new EdgeInsets.all(20.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(
                                            listCompany[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
//                                      new Text('                    '),
                                          new Text(
                                              "Balance:  ${listCompany[index].balance.toString()} \u20AC",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ]),
                                    new Row(children: <Widget>[
                                      new Text('',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                    listCompany[index].offers.length != 0 ?
                                    Column(children: <Widget>[
                                      ..._buildRowList(listCompany[index].offers)
                                    ],) : Text(''),
                                    listCompany[index].has_menu
                                        ? new Row(children: <Widget>[
                                            RaisedButton(
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0)),
                                                child: Text("Menu",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0)),
                                                color: Colors.redAccent,
                                                onPressed: () {
                                                  var route =
                                                      new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new Menu(
                                                            companyName:
                                                                listCompany[
                                                                        index]
                                                                    .name),
                                                  );
                                                  Navigator.of(context)
                                                      .push(route);
                                                }),
                                          ])
                                        : Text('')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
    );
  }
}
