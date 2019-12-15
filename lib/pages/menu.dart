import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:fresa/bloc/menu_model.dart';
import 'package:fresa/models/category.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:scoped_model/scoped_model.dart';

class Menu extends StatelessWidget {
  final String token_t;
  final String companyName;

  Menu({Key key, this.token_t, this.companyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MenuModel>(
      model: menuModel,
      child: ScopedModelDescendant<MenuModel>(builder: (context, child, model) {
        return MenuPage(
            model: model, token_t: token_t, companyName: companyName);
      }),
    );
  }
}

class MenuPage extends StatefulWidget {
  final String token_t;
  final String companyName;
  final MenuModel model;

  MenuPage({Key key, this.token_t, this.companyName, this.model})
      : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  bool _isAppbar = true;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    widget.model.initFunc();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        appBarStatus(false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        appBarStatus(true);
      }
    });
  }

  void appBarStatus(bool status) {
    setState(() {
      _isAppbar = status;
    });
  }

  item(element) {
    return RawMaterialButton(
      padding: EdgeInsets.fromLTRB(43.0, 0.0, 20.0, 0.0),
      child: new Container(
        color: Color.fromRGBO(254, 237, 235, 1),
        child: new SizedBox(
          height: 80.0,
          child: new Card(
            elevation: 0,
            child: new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              color: Color.fromRGBO(254, 237, 235, 1),
              child: new Column(
                children: <Widget>[
                  new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              '${element.name}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        ),
                        Container(
                          child: Text('${element.price.toString()} ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Gilroy',
                                  color: Color.fromRGBO(135, 135, 135, 1),
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  height: 1.2)),
                        ),
                        Container(
                          child: Text('\u20AC',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Gilroy',
                                  color: Color.fromRGBO(135, 135, 135, 1),
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  height: 1.2)),
                        )
                      ]),
//                  new Row(
//                      mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//
//                        Container(
//                          width: 290,
//                          child: Text('fdfgdfgdfgdfg dfg dg dfg g df dfg dfgdf dfgfdg gfdgdfgdf gfdgdfgdf',
//                              style: TextStyle(
//                                  fontSize: 12.0,
//                                  fontFamily: 'Gilroy',
//                                  color: Color.fromRGBO(135, 135, 135, 1),
//                                  fontWeight: FontWeight.w900,
//                                  fontStyle: FontStyle.normal,
//                                  height: 1.2)),
//                        )
//
//                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    MenuModel model = widget.model;

    return SafeArea(
        child: new Scaffold(
      backgroundColor: Color.fromRGBO(254, 237, 235, 1),
//      appBar: PreferredSize(
//        preferredSize: Size.fromHeight(123.0),
//        child: new AppBar(
//          automaticallyImplyLeading: false,
//          backgroundColor: Color.fromRGBO(254, 237, 235, 1),
//          elevation: 0,
//          title: Padding(
//            padding: EdgeInsets.fromLTRB(32.0, 39.0, 0.0, 0.0),
//            child: new Text('La Carta',
//                style: TextStyle(
//                  height: 0.8,
//                  fontWeight: FontWeight.w900,
//                  color: Color.fromRGBO(87, 86, 86, 1),
//                )),
//          ),
//        ),
//      ),
      body: FutureBuilder<List<CategoryCompany>>(
          future: model.listCompany,
          builder: (_, AsyncSnapshot<List<CategoryCompany>> snapshot) {
            var listMenu = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                  color: Color.fromRGBO(254, 237, 235, 1),
                  child: GroupedListView<dynamic, String>(
                    groupBy: (element) {
                      return element.category_name;
                    },
                    elements: listMenu,
                    sort: true,
                    groupSeparatorBuilder: (String value) {
                      i += 1;
                      if (i == 1) {
                        return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(43.0, 32.0, 20.0, 0.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('La Carta',
                                        style: TextStyle(
                                          height: 0.8,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Color.fromRGBO(87, 86, 86, 1),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                    ),
                                    Text(
                                      value,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          height: 1.2),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      } else {
                        return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(43.0, 0.0, 20.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                ),
                                Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      height: 1.2),
                                ),
                              ],
                            ));
                      }
                    },
                    itemBuilder: (c, element) {
                      return item(element);
                    },
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ));
  }
}
