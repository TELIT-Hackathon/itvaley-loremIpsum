import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/extensions/extensions.dart';
import 'package:it_valey_hackathon_2022/services/RoleApiService.dart';

import '../../entity/Role.dart';

class LoadingRoleText extends StatefulWidget{
  final String id;

  const LoadingRoleText({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _LoadingRoleTextState();
}

class _LoadingRoleTextState extends State<LoadingRoleText>{
  String? _rolesStr;
  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {

    RoleApiService.getRolesByMessage(widget.id).then((List<Role> roles){
      String str = "";
      roles.forEach((Role role) => {str += "${role.title}, "});

      setState(() {
        _rolesStr = str.substring(0, str.length - 2);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return (_rolesStr == null) ?
    Container(
      child: null,
    ) :
    Padding(
      padding: const  EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(key: _widgetKey,"$_rolesStr", style: TextStyle(fontWeight: FontWeight.bold),),
      ).animate()
          .fade(duration: 100.ms)
          .scale(delay: 100.ms)

    );
  }
}