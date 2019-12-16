import 'package:fresa/models/category.dart';
import 'package:fresa/models/company.dart';
import 'company_api_provider.dart';
import 'menu_api_provider.dart';
import 'push_token_api_provider.dart';


class Repository {

  final pushTokenApiProvider = PushTokenApiProvider();
  pushToken(firebaseToken) {
    return pushTokenApiProvider.pushTokenToServer(firebaseToken);
  }

  final companyApiProvider = CompanyApiProvider();
  Future<List<Company>> fetchCompany(toket_t) async {
    return companyApiProvider.fetchCompanyData(toket_t);
  }

  final menuApiProvider = MenuApiProvider();
  Future <List<CategoryCompany>> fetchMenu(String companyName) async {
    return menuApiProvider.fetchMenuCompanyData(companyName);
  }

}