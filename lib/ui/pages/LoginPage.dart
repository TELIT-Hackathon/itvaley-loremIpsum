import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:it_valey_hackathon_2022/redux/AppState.dart';
import 'package:it_valey_hackathon_2022/redux/actions/SetUserState.dart';
import 'package:it_valey_hackathon_2022/ui/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entity/User.dart';
import '../../services/FakeAuthService.dart';

import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _isActiveButton = true;
  List<User> _fakeUsers = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Store<AppState> store = StoreProvider.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Center(
              child: SizedBox(
                width: width * 0.8,
                child: ElevatedButton(
                  onPressed: (_isActiveButton == false) ? null : () async {
                    bool res = await _loginWithFakeUser();
                    if(res == false){
                      setState(() {
                        _isActiveButton = true;
                      });
                    }
                  } ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Login")
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: (_fakeUsers.isEmpty) ? null : Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26
                ),
                child: Center(
                  child: SizedBox(
                    width: width*0.8,
                    height: height*0.5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _fakeUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            User user = _fakeUsers[index];
                            return GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                await prefs.setString("user_name", user.name);
                                await prefs.setString("user_last_name", user.lastName);
                                await prefs.setString("user_type", user.type);
                                await prefs.setString("user_id", user.id);
                                await prefs.setStringList("roles", user.roles);

                                store.dispatch(SetUserState(user: user));

                                Future.delayed(const Duration(microseconds: 500)).then((value)
                                  => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomePage())
                                  )
                                );
                              },
                              child: ListTile(
                                title: Text("${user.name} ${user.lastName}"),
                                trailing: Text("${user.type}"),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }

  Future<bool> _loginWithFakeUser() async{
    setState(() {
      _isActiveButton = false;
    });

    try {
      List<User> users = await FakeAuthService.getFakeUsers();

      if(users.isEmpty){
        return false;
      }

      setState(() {
        _fakeUsers = users;
      });

      return true;
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

}