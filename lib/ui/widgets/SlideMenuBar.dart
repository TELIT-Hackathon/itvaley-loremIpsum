import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:it_valey_hackathon_2022/redux/actions/SetAppState.dart';
import 'package:it_valey_hackathon_2022/ui/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import '../../redux/AppState.dart';

class SlideMenuBar extends StatelessWidget{
  const SlideMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(239, 74, 77, 1)
              ),
              child: Text(
                '<hello, world!/>',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                ),
              )
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();

              Store<AppState> store = StoreProvider.of(context);
              store.dispatch(SetAppState(user: null));

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }


}