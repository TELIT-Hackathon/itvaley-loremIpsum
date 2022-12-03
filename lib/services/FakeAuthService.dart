import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:it_valey_hackathon_2022/entity/User.dart';

class FakeAuthService{

  static Future<List<User>> getFakeUsers() async {
    final String response = await rootBundle.loadString('lib/data/fakeUsers.json');
    final data = await json.decode(response);
    List<User> users = List<User>.from(data.map((model)=> User.fromJson(model)));

    return users;
  }

}