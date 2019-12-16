import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresa/bloc/offers_model.dart';
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:fresa/models/company.dart';
import 'package:fresa/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io' show Platform;

import 'login_phone_page.dart';

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
    print('INIT OFFER ');
    i = 0;
    widget.model.initFunc(context, widget.token_t);
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

  int i = 0;

  ListViewFuncAndroid(listCompany) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: listCompany.length,
      itemBuilder: (BuildContext context, int index) {
        i += 1;
        return Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                i == 1
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(39.0, 37.0, 0.0, 20.0),
                        child: new Text(
                          'Mis Oportunidades',
                          style: TextStyle(
                              color: Color.fromRGBO(87, 86, 86, 1),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              fontSize: 18,
                              height: 1),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                Center(
                  child: new Container(
                    child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: Text(''),
                            color: index == 0
                                ? Color.fromRGBO(254, 237, 235, 1)
                                : Colors.white,
//                          height: 20,
                            height:  index == 0 ? 50 : 20,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 20.0,
                                    offset: new Offset(0.0, -5.0),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: index == 0
                                    ? new BorderRadius.only(
                                        topLeft: const Radius.circular(24.0),
                                        topRight: const Radius.circular(24.0))
                                    : new BorderRadius.only(
                                        topLeft: const Radius.circular(24.0),
                                        topRight: const Radius.circular(24.0))),
                            padding: new EdgeInsets.all(0.0),
                            child: new Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    new ClipRRect(
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(24.0),
                                          topRight:
                                              const Radius.circular(24.0)),
                                      child: Image.asset(
                                        'res/images/card_image.png',
                                      ),
                                    ),
                                    Positioned(
                                      top: 200,
                                      left: 29,
                                      child: new Text(
                                        listCompany[index].name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      top: 225,
                                      left: 310,
                                      child: Container(
                                        width: 72,
                                        height: 36,
                                        decoration: new BoxDecoration(
                                            color:
                                                Color.fromRGBO(195, 48, 48, 1),
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(10.0),
                                                bottomRight:
                                                    const Radius.circular(
                                                        10.0))),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              15.0, 2.5, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text("Saldo",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 8)),
                                              new Text(
                                                  "${listCompany[index].balance.toString().split('.')[0]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
//                                    height: 240,
                                      height: 280,
                                      child: Text(''),
                                    )
                                  ],
                                ),

//                          Container(
//                            margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
//                            child: new Text(
//                              listCompany[index].name,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),

//                          new Row(
//                              mainAxisSize: MainAxisSize.max,
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                new Text('',
//                                    style:
//                                        TextStyle(fontWeight: FontWeight.bold)),
//                              ]),
//                          listCompany[index].offers.length != 0 ?
//                          Column(children: <Widget>[
//                            ..._buildRowList(listCompany[index].offers)
//                          ],) : Text(''),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Card(
                                          color:
                                              Color.fromRGBO(254, 237, 235, 1),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      16.0)),
                                          child: new Container(
                                            padding: new EdgeInsets.fromLTRB(
                                                0.0, 20.0, 40.0, 20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  child: SvgPicture.asset(
                                                    'res/images/present.svg',
                                                    width: 36.0,
                                                    height: 36.0,
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                      'Reciba un pequeño vaso de cerveza como regalo al realizar el pedido desde 15 euros.'),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ]),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 0.0),
                                ),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Card(
                                          color:
                                              Color.fromRGBO(254, 237, 235, 1),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      16.0)),
                                          child: new Container(
                                            padding: new EdgeInsets.fromLTRB(
                                                0.0, 20.0, 40.0, 20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  child: SvgPicture.asset(
                                                    'res/images/present.svg',
                                                    width: 36.0,
                                                    height: 36.0,
                                                  ),
                                                ),

//
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                      'Dos pizzas por el precio de una. Todos los jueves durante todo el día.'),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ]),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 10.0, 30.0, 10.0),
                                ),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("LA CARTA",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 0.0, 0.0),
                                      ),
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("WHATSAPP",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 10.0, 0.0),
                                      ),
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("GOOGLE MAPS",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),
//                                    Padding(
//                                      padding: EdgeInsets.fromLTRB(
//                                          0.0, 0.0, 0.0, 0.0),
//                                      child: Container(height: 20,),
//                                    ),
                                    ]),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 10.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

//                i == listCompany.length ? Container(
//                  height: 10,
//                  color: Colors.white,
//                ): Container(
//                  height: 0,
//                ),
              ],
            ));
      },
    );
  }

  ListViewFuncIOS(listCompany) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: listCompany.length,
      itemBuilder: (BuildContext context, int index) {
        i += 1;

        return Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                i == 1
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(39.0, 37.0, 0.0, 20.0),
                        child: new Text(
                          'Mis Oportunidades',
                          style: TextStyle(
                              color: Color.fromRGBO(87, 86, 86, 1),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              fontSize: 18,
                              height: 1),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                Center(
                  child: new Container(
                    child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: Text(''),
                            color: index == 0
                                ? Color.fromRGBO(254, 237, 235, 1)
                                : Colors.white,
                            height: 20,
//                      height: 50, android
                          ),
                          Container(
                            decoration: new BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 20.0,
                                    offset: new Offset(0.0, -5.0),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: index == 0
                                    ? new BorderRadius.only(
                                        topLeft: const Radius.circular(24.0),
                                        topRight: const Radius.circular(24.0))
                                    : new BorderRadius.only(
                                        topLeft: const Radius.circular(24.0),
                                        topRight: const Radius.circular(24.0))),
                            padding: new EdgeInsets.all(0.0),
                            child: new Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    new ClipRRect(
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(24.0),
                                          topRight:
                                              const Radius.circular(24.0)),
                                      child: Image.asset(
                                        'res/images/card_image.png',
                                      ),
                                    ),
                                    Positioned(
                                      top: 190,
                                      left: 29,
                                      child: new Text(
                                        listCompany[index].name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      top: 200,
                                      left: 280,
                                      child: Container(
                                        width: 72,
                                        height: 36,
                                        decoration: new BoxDecoration(
                                            color:
                                                Color.fromRGBO(195, 48, 48, 1),
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(10.0),
                                                bottomRight:
                                                    const Radius.circular(
                                                        10.0))),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 2.5, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text("Saldo:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 8)),
                                              new Text(
                                                  "${listCompany[index].balance.toString().split('.')[0]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 240,
//                                height: 280, android
                                      child: Text(''),
                                    )
                                  ],
                                ),

//                          Container(
//                            margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
//                            child: new Text(
//                              listCompany[index].name,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),

//                          new Row(
//                              mainAxisSize: MainAxisSize.max,
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                new Text('',
//                                    style:
//                                        TextStyle(fontWeight: FontWeight.bold)),
//                              ]),
//                          listCompany[index].offers.length != 0 ?
//                          Column(children: <Widget>[
//                            ..._buildRowList(listCompany[index].offers)
//                          ],) : Text(''),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Card(
                                          color:
                                              Color.fromRGBO(254, 237, 235, 1),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      16.0)),
                                          child: new Container(
                                            padding: new EdgeInsets.fromLTRB(
                                                0.0, 20.0, 40.0, 20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  child: SvgPicture.asset(
                                                    'res/images/present.svg',
                                                    width: 36.0,
                                                    height: 36.0,
                                                  ),
                                                ),

//
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                      'Reciba un pequeño vaso de cerveza como regalo al realizar el pedido desde 15 euros.'),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ]),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 0.0),
                                ),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Card(
                                          color:
                                              Color.fromRGBO(254, 237, 235, 1),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      16.0)),
                                          child: new Container(
                                            padding: new EdgeInsets.fromLTRB(
                                                0.0, 20.0, 40.0, 20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: 80,
                                                  child: SvgPicture.asset(
                                                    'res/images/present.svg',
                                                    width: 36.0,
                                                    height: 36.0,
                                                  ),
                                                ),

//
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                      'Dos pizzas por el precio de una. Todos los jueves durante todo el día.'),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ]),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 10.0, 30.0, 10.0),
                                ),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("LA CARTA",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 0.0, 0.0),
                                      ),
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("WHATSAPP",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 10.0, 0.0),
                                      ),
                                      new SizedBox(
                                        width: 100.0,
                                        height: 28.0,
                                        child: OutlineButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            child: Text("GOOGLE MAPS",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        191, 40, 73, 1),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.0)),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new Menu(
                                                        companyName:
                                                            listCompany[index]
                                                                .name),
                                              );
                                              Navigator.of(context).push(route);
                                            }),
                                      ),
                                    ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    OfferModel model = widget.model;
    return new Scaffold(
        backgroundColor: Color.fromRGBO(254, 237, 235, 1),
        appBar: new AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(254, 237, 235, 1),
          elevation: 0,
          title: new Text(
            'Mis Oportunidades',
            style: TextStyle(
                color: Color.fromRGBO(87, 86, 86, 1),
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
            fontSize: 18,
            height: 1),

          ),
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
                if (Platform.isAndroid) {
                  print('andropid');
                  i = 0;
                  return Stack(
                      children: <Widget>[ListViewFuncAndroid(listCompany)]);
                } else {
                  print('ios');
                  i = 0;
                  return Stack(
                      children: <Widget>[ListViewFuncIOS(listCompany)]);
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
