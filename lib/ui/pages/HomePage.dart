import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/AppState.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    print(store.state.user?.name);

    return Scaffold(
      body: Center(
        child: Text("Home page"),
      ),
    );
  }

}