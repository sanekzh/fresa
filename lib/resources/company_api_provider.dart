import 'dart:convert';

import 'package:fresa/common/functions/getToken.dart';
import 'package:fresa/models/company.dart';
import 'package:http/http.dart' show Client;


class CompanyApiProvider {
  Client client = Client();

  Future<List<Company>> fetchCompanyData() async {
    var token;
    await getToken().then((result) {
      token = result;
    });
    String url = "http://api.mermelando.es/api/customer/companies/list/";
    Map<String, String> headerToken = {
      "Content-type": "application/json",
      "X-Token": "Token ${token}"
    };
    final response = await client.get(url, headers: headerToken);
    if (response.statusCode == 200) {
      List<Company> listCompany = (json.decode(utf8.decode(response.bodyBytes))['results'] as List)
          .map((data) => new Company.fromJson(data))
          .toList();
      return listCompany;
    } else {
      throw Exception('Failed to load company');
    }
  }

}

