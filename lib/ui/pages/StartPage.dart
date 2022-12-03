import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:it_valey_hackathon_2022/ui/pages/HomePage.dart';
import 'package:it_valey_hackathon_2022/ui/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import '../../entity/User.dart';
import '../../redux/AppState.dart';
import '../../redux/actions/SetUserState.dart';

class StartPage extends StatelessWidget{
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    int timestampOfStart = DateTime.now().millisecondsSinceEpoch;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SharedPreferences.getInstance().then((SharedPreferences prefs){
      String? id = prefs.getString("user_id");
      if(id == null){

        int actualTimestamp = DateTime.now().millisecondsSinceEpoch;
        int delta = actualTimestamp - timestampOfStart;
        if(delta < 1000){
          Future.delayed(Duration(milliseconds: 1000 - delta)).then((value){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage())
            );
          });
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage())
          );
        }
      } else {
        String? lastName = prefs.getString("user_last_name");
        String? type = prefs.getString("user_type");
        String? name = prefs.getString("user_name");
        List<String>? roles = prefs.getStringList("roles");

        User user = User(id: id, name: name!, lastName: lastName!, type: type!, roles: roles!);

        Store<AppState> store = StoreProvider.of(context);
        store.dispatch(SetUserState(user: user));

        int actualTimestamp = DateTime.now().millisecondsSinceEpoch;
        int delta = actualTimestamp - timestampOfStart;
        if(delta < 1000){
          Future.delayed(Duration(milliseconds: 1000 - delta)).then((value){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage())
            );
          });
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage())
          );
        }
      }
    });


    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width*0.8,
          height: height*0.1,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(239, 74, 77, 1),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                    "<hello, world!/>",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}