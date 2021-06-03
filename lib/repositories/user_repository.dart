import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phase_1/model/user_model.dart';

class UserRepository {
  Future<List<Data>> getUser() async {
    Uri url = Uri.parse("https://reqres.in/api/users");
    var response = await http.get(url);

    var jsonObject = json.decode(response.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<Data> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(Data.fromJSON(listUser[i]));
    }

    return users;
  }
}
