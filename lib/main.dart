import 'package:flutter/material.dart';
import 'package:it_valey_hackathon_2022/redux/AppState.dart';
import 'package:it_valey_hackathon_2022/redux/reducer.dart';
import 'package:it_valey_hackathon_2022/ui/pages/StartPage.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  final Store<AppState> store = Store(
      reducer,
      initialState: AppState.initNewAppState()
  );

  runApp(
      StoreProvider(store: store, child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '"<hello, world!/>',
      home: StartPage(),
    );
  }
}