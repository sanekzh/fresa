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
  Future<List<Company>> fetchCompany() async {
    return companyApiProvider.fetchCompanyData();
  }

  final menuApiProvider = MenuApiProvider();
  Future <List<CategoryCompany>> fetchMenu() async {
    return menuApiProvider.fetchMenuCompanyData();
  }

}