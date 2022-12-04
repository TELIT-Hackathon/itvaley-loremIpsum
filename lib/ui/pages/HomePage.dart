import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/extensions/extensions.dart';
import 'package:it_valey_hackathon_2022/services/MessageApiService.dart';
import 'package:it_valey_hackathon_2022/ui/pages/TopicPage.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/LoadingNameText.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/MyAppBar.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/SlideMenuBar.dart';

import '../../entity/Message.dart';
import '../widgets/LoadingRoleText.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Message> _hotTopics = List.empty(growable: true);


  @override
  void initState() {
    MessageApiService.getHotMessagesDescending().then((messages){
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
            ) : Expanded(
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
                            child: Card(
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                    message.title,
                                    style: const TextStyle(
                                        fontSize: 18
                                    )
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LoadingRoleText(id: message.id),
                                    LoadingNameText(id: message.authorId),
                                  ],
                                ),
                                // leading: IntrinsicWidth(child: LoadingRoleText(id: message.id,)),
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
                            ),
                          ).animate()
                              .fade(duration: 100.ms)
                              .scale(delay: 100.ms);
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