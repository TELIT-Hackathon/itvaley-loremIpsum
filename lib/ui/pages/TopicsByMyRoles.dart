import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:it_valey_hackathon_2022/ui/pages/TopicPage.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/AnswerMessage.dart';
import 'package:redux/redux.dart';
import '../../entity/Message.dart';
import '../../redux/AppState.dart';
import '../../services/MessageApiService.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/SlideMenuBar.dart';

class TopicsByMyRoles extends StatefulWidget{
  const TopicsByMyRoles({super.key});

  @override
  State<StatefulWidget> createState() => _TopicsByMyRolesState();  
}

class _TopicsByMyRolesState extends State<TopicsByMyRoles>{
  List<Message>? _messages;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);

    MessageApiService.getMessagesByUserRoles(store.state.user!.id).then((List<Message> messages){
      setState(() {
        _messages = messages;
      });
    });

    return Scaffold(
            drawer: const SlideMenuBar(),
            appBar: const MyAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (_messages == null) ? (const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(234, 74, 77, 1),
                  )
              )): (_messages!.isEmpty) ? (
              const Center(child: Text("No interesting topic for you"),)
              ) : ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                controller: ScrollController(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _messages!.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnswerMessage(message: _messages![index]);
                }
              ),
            ),
    );
  }
  
}