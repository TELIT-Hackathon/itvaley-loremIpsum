import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../redux/AppState.dart';
import 'package:redux/redux.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    String name = store.state.user!.name.substring(0,1);
    String lastName = store.state.user!.lastName.substring(0,1);


    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromRGBO(234, 74, 77, 1),
      title: const Text("<hello, world!/>"),
      actions: [
        ClipRRect(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "$name$lastName",
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20
                        )
                    ),
                  )
              ),
            ),
          ),
        ),
      ]
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

}