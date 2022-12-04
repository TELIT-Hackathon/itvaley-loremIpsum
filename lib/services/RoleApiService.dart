import 'package:it_valey_hackathon_2022/entity/MessageRole.dart';
import 'package:it_valey_hackathon_2022/entity/Role.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/UserRole.dart';

class RoleApiService {
  static Future<List<Role>> getRolesByUser(String userId) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/getuserroles");
    final http.Response response = await http.get(requestUrl, headers: {"user_id":userId});
    final data = json.decode(response.body);
    List<Role> roles =
      List<Role>.from(data.map((model) => Role.fromJson(model)));

    return roles;
  }

  static Future<List<Role>> getRolesByMessage(String messageId) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/getuserroles");
    final http.Response response = await http.get(requestUrl, headers: {"message_id":messageId});
    final data = json.decode(response.body);
    List<Role> roles =
      List<Role>.from(data.map((model) => Role.fromJson(model)));

    return roles;
  }

  static Future<int> createNewRole(Role role) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/create_role");
    final http.Response response = await http.post(requestUrl, body: json.encode(role));

    return response.statusCode;
  }

  static Future<List<int>> createNewUserRoles(List<UserRole> roles) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/create_user_roles");
    List<int> responseCodes = List.filled(roles.length, 0);
    for(UserRole role in roles){
      responseCodes[roles.indexOf(role)] = (await http.post(requestUrl, body: roles.map((role) => json.encode(role)))).statusCode;
    }

    return responseCodes;
  }

  static Future<List<int>> createNewMessageRoles(List<MessageRole> roles) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/create_message_roles");
    List<int> responseCodes = List.filled(roles.length, 0);
    for(MessageRole role in roles){
      responseCodes[roles.indexOf(role)] = (await http.post(requestUrl, body: roles.map((role) => json.encode(role)))).statusCode;
    }

    return responseCodes;
  }
}