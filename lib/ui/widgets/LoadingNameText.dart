import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(4.0),
          child: Text("$_name $_lastName"),
        );
  }
}