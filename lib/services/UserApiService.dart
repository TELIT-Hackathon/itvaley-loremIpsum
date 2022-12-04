import 'package:it_valey_hackathon_2022/entity/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  static Future<List<User>> getAllUsers() async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/get_all_users");
    final http.Response response = await http.get(requestUrl);
    final data = json.decode(response.body);
    List<User> users = List<User>.from(data.map((model) => User.fromJson(model)));

    return users;
  }


  static Future<User> getUsersById(String userId) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/get_user_by_id?user_id=$userId");
    final http.Response response = await http.get(requestUrl);
    User user = User.fromJson(response.body);

    return user;
  }

  static Future<User> getAllAboutUserById(String userId) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/get_all_user_info?user_id=$userId");
    final http.Response response = await http.get(requestUrl);
    final data = json.decode(response.body);
    List<User> user = List<User>.from(data.map((model) => User.fromJson(model)));

    return user[0];
  }

  static Future<int> createNewUser(User user) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/create_user");
    final http.Response response = await http.post(requestUrl, body: json.encode(user));

    return response.statusCode;
  }
}