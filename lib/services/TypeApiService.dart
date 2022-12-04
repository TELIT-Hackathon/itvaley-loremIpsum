import 'package:it_valey_hackathon_2022/entity/Type.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TypeApiService{
  static Future<Type> getUserType(String typeId) async {
    Uri requestedUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/get_user_type?type_id=$typeId");
    final http.Response response = await http.get(requestedUrl);
    final data = json.decode(response.body);
    Type type = Type.fromJson(data);

    return type;
  }
}