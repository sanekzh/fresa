import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/pages/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:fresa/common/functions/saveLogout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fresa/models/category.dart';
import 'package:grouped_list/grouped_list.dart';



class MenuPage extends StatefulWidget {
  final String token_t;
  String companyName;

  MenuPage({
    Key key,
    this.token_t,
    this.companyName
  }) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String _username = '';
  String _individualName = '';
  String _token = '';
  List<CategoryCompany> list_items = List();
  var isLoading = false;

  int max_limit = 10;
  String _ordering = '';

  @override
  void initState() {
    super.initState();
    this.fetchMenuCompanyData();
    loadUserNameData().then((value) {
      setState(() {
        _username = value != null ? value : '';
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
      });
    });
    loadTokenData().then((value) {
      setState(() {
        _token = value != null ? value : '';
        print("!!!!!${_token}");
      });
    });
  }
  Future<String> fetchMenuCompanyData() async {
    setState(() {
      isLoading = true;
    });
    var token;
    if (widget.token_t != null) {
      token = widget.token_t;
    } else {
      await getToken().then((result) {
        token = result;
      });
    }

    print("fetchCategoryData - ${token}");
    String url = "http://api.mermelando.es/api/menu/category/list";
    Map<String, String> headerToken = {
      "Content-type": "application/json",
      "X-Token": "Token ${token}"
    };
    List list = [];
    final response_company = await http.get(url, headers: headerToken);
    print(json.decode(response_company.body)['results'] as List);
    if (response_company.statusCode == 200) {
      print("list get request - ${response_company.body}");
      for(var i in json.decode(response_company.body)['results'] as List){
        list = (i['items'] as List)
          .map((data) => new CategoryCompany.fromJson(data, i))
          .toList();
        list_items += list;
      }
//      list_items = (json.decode(response_company.body)['results'] as List)
//          .map((data) => new ItemsCompany.fromJson(data))
//          .toList();
      print(list_items);
      setState(() {
        isLoading = false;
      });

    } else {
      throw Exception('Failed to load categories');
    }
    return "Success";
  }

  Future<String> loadTokenData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastToken');
  }

  Future<String> loadUserNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastUser');
  }

  Future<String> loadIndiviadualNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastIndividualName');
  }

  setData() {
    loadUserNameData().then((value) {
      setState(() {
        _username = value != null ? value : '';
      });
    });
    loadIndiviadualNameData().then((value) {
      setState(() {
        _individualName = value != null ? value : '';
      });
    });
  }

  item(element) {
    return RawMaterialButton(
      child: new Container(
        child: new SizedBox(
          height: 100.0,
          child: new Card(
            elevation: 10,
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Text('${element.name}')
                        ),
                        Container(child: Text('${element.price.toString()} \u20AC',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
                                fontWeight:
                                FontWeight.bold)),)
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text(widget.companyName != '' ? '${widget.companyName}' : ''),
      ),
      body: Builder(builder: (BuildContext context) {
        return new Container(
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : list_items.length != 0
              ?
          GroupedListView<dynamic, String>(
            groupBy: (element) {
              return element.category_name;

            },
            elements: list_items,
            sort: true,
            groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child:Row(children: <Widget>[
                  Icon(
                    Icons.category,
                    color: Colors.blue.shade400,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  ),
                  Text(
                    value,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],)

            ),
            itemBuilder: (c, element) {
              return item(element);
            },
          )
              : Center(child: Text('You don\'t have a categories ')),
        );
      }),
    );
  }
}
