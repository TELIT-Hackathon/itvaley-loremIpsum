import 'package:it_valey_hackathon_2022/entity/User.dart';

class AppState{
  final User? user;

  AppState({required this.user});

  static initNewAppState(){
    return AppState(
        user: null
    );
  }
}