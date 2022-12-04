import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/extensions/extensions.dart';
import 'package:it_valey_hackathon_2022/services/UserApiService.dart';

import '../../entity/User.dart';

class LoadingNameText extends StatefulWidget{
  final String id;

  const LoadingNameText({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _LoadingNameTextState();
}

class _LoadingNameTextState extends State<LoadingNameText>{
  String? _name;
  String? _lastName;

  @override
  void initState() {
    UserApiService.getAllAboutUserById(widget.id).then((User user){
      setState(() {
        _name = user.name;
        _lastName = user.lastName;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_name == null || _lastName == null) ?
        Container(
          child: null,
        ) :
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(246, 140, 141, 1)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("$_name $_lastName")
            ),
          ),
        ).animate()
            .fade(duration: 100.ms)
            .scale(delay: 100.ms);
  }
}