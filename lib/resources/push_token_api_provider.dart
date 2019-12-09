import 'package:fresa/common/functions/getToken.dart';
import 'package:http/http.dart' show Client;


class PushTokenApiProvider {
  Client client = Client();

  void pushTokenToServer(firebaseToken) async {
    var url = 'http://api.mermelando.es/api/customer/firebase/update/';
    Map<String, String> body = {
      'firebase_token': firebaseToken,
    };
    var token_user;
    await getToken().then((result) {
      token_user = result;
    });
    print("FIREBASE UPDATE TOKEN - ${token_user}");
    if (token_user != null) {
      Map<String, String> headerToken = {"X-Token": "Token ${token_user}"};
      final response = await client.put(
        url,
        headers: headerToken,
        body: body,
      );
      if (response.statusCode == 200) {
        print('OK UPDATE');
        print(response.body);
      } else {
        print(response.body);
        print('ERROR UPDATE');
      }
    }
  }
}