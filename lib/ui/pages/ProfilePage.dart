import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/AppState.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state){
            String name = state.user!.name;
            String lastName = state.user!.lastName;
            String roles = "";

            state.user?.roles.forEach((element) {
              roles += "${element}, ";
            });

            roles = roles.substring(0, roles.length - 2);

          return Scaffold(
            body: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text(
                      "${name} ${lastName}",
                      style: TextStyle(
                        fontSize: 30
                      ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "Your roles:",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text(
                        roles,
                        style: const TextStyle(
                            fontSize: 30
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          );
        }
        );
  }
}
