import 'package:it_valey_hackathon_2022/entity/Status.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatusApiService{
  static Future<int> createNewMessageStatus(Status status) async {
    Uri requestUrl = Uri.parse("https://quiet-brook-94275.herokuapp.com/create_messages_status");
    final http.Response response = await http.post(requestUrl, body: json.encode(status));

    return response.statusCode;
  }
}