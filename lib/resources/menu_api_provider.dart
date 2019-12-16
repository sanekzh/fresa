import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/models/category.dart';
import 'package:http/http.dart' show Client;


class MenuApiProvider {
  Client client = Client();

  Future <List<CategoryCompany>> fetchMenuCompanyData(String companyName) async {
  var token;

  await getToken().then((result) {
    token = result;
  });

  String url = "http://api.mermelando.es/api/menu/category/list?company_name=$companyName";
  Map<String, String> headerToken = {
    "Content-type": "application/json",
    "X-Token": "Token ${token}"
  };
  List list = [];
  print(url);
  List<CategoryCompany> listCompany = List();
  final response = await client.get(url, headers: headerToken);
  if (response.statusCode == 200) {
    for(var i in json.decode(utf8.decode(response.bodyBytes))['results'] as List){
      list = (i['items'] as List)
          .map((data) => new CategoryCompany.fromJson(data, i))
          .toList();
      listCompany += list;
    }
    return listCompany;
  } else {
    throw Exception('Failed to load categories');
  }
}
}