import 'package:flutter/material.dart';
import 'package:it_valey_hackathon_2022/services/MessageApiService.dart';
import 'package:it_valey_hackathon_2022/ui/pages/TopicPage.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/LoadingNameText.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/MyAppBar.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/SlideMenuBar.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../entity/Message.dart';
import '../../redux/AppState.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Message> _hotTopics = List.empty(growable: true);


  @override
  void initState() {
    GetMessagesService.getHotMessagesDescending().then((messages){
      List<Message> hotTopics = List.empty(growable: true);
      messages.forEach((Message message){
        hotTopics.add(message);
      });
      
      setState(() {
        _hotTopics = hotTopics;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const SlideMenuBar(),
      appBar: const MyAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
                "Hot topics for you:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
            ),
          ),
          Container(
            child: (_hotTopics.isEmpty) ? (
                const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(234, 74, 77, 1),
                  )
                )
            ) : Container(
              child: Scrollbar(
                child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()
                        ),
                    controller: ScrollController(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                        itemCount: _hotTopics.length,
                        itemBuilder: (BuildContext context, int index) {
                          Message message = _hotTopics[index];

                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TopicPage(message: message))
                              );
                            },
                            child: ListTile(
                              title: Text(message.title),
                              subtitle: LoadingNameText(id: message.authorId),
                              trailing: IntrinsicWidth(
                                child: Row(
                                  children: [
                                    Text("${message.rating} "),
                                    const Icon(
                                        Icons.star_rate,
                                        color: Color.fromRGBO(234, 74, 77, 1),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}