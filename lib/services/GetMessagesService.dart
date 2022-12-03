import 'package:it_valey_hackathon_2022/entity/Message.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMessageService {
  static Future<List<Message>> getHotMessagesDescending() async {
    // TODO: ADD API GET URL
    Uri requestUrl = Uri.http("authority");
    final http.Response response = await http.get(requestUrl);
    final data = json.decode(response.body);
    List<Message> messages =
        List<Message>.from(data.map((model) => Message.fromJson(model)));

    return messages;
  }
}