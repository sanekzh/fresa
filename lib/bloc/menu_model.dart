import 'package:fresa/models/category.dart';
import 'package:fresa/resources/repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuModel extends Model {
  final _repository = Repository();

   String _token = '';
  get token => _token;
  set setToken(String str){
    _token = str;
    notifyListeners();
  }

  bool _isLoading = false;
  get isLoading => _isLoading;
  set setIsLoading(bool load){
    _isLoading = load;
    notifyListeners();
  }

  String _username = '';
  get userName => _username;
  set setUserName(String str){
    _username = str;
    notifyListeners();
  }

  Future <List<CategoryCompany>> _listMenu;
  Future <List<CategoryCompany>> get listCompany => _listMenu;
  set setListMenu(Future <List<CategoryCompany>> value) {
    _listMenu = value;
    notifyListeners();
  }

  void initFunc(String companyName) {
    setListMenu = _repository.fetchMenu(companyName);
    loadUserNameData().then((value) {
      _username = value != null ? value : '';
      notifyListeners();
    });

    loadTokenData().then((value) {
      _token = value != null ? value : '';
      notifyListeners();
    });
    notifyListeners();
  }

  Future<String> loadTokenData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastToken');
  }

  Future<String> loadUserNameData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('LastUser');
  }

}

MenuModel menuModel = MenuModel();

