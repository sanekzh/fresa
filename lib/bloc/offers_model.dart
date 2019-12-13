import 'package:fresa/models/company.dart';
import 'package:fresa/resources/repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferModel extends Model {
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

  Future<List<Company>> _listCompany;
  Future<List<Company>> get listCompany => _listCompany;
  set setListCompany(Future<List<Company>> value) {
    _listCompany = value;
    notifyListeners();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void initFunc(context, token_t) {
    print(token_t);
    setListCompany = _repository.fetchCompany(token_t);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    loadUserNameData().then((value) {
        _username = value != null ? value : '';
        notifyListeners();
    });

    loadTokenData().then((value) {
        _token = value != null ? value : '';
        print("!!!!!${_token}");
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

OfferModel offerModel = OfferModel();
