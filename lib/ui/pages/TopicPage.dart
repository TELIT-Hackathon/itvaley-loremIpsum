import 'package:flutter/material.dart';
import 'package:it_valey_hackathon_2022/entity/Message.dart';
import 'package:it_valey_hackathon_2022/services/MessageApiService.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/AnswerMessage.dart';
import 'package:it_valey_hackathon_2022/ui/widgets/LoadingNameText.dart';

import '../widgets/MyAppBar.dart';
import '../widgets/SlideMenuBar.dart';

class TopicPage extends StatefulWidget{
  final Message message;

  const TopicPage({super.key, required this.message});

  @override
  State<StatefulWidget> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage>{
  bool _isLiked = false;
  bool _isDisliked = false;

  List<Message>? _answers;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {

    MessageApiService.getMessagesByParent(widget.message.id).then((List<Message> messages){
      setState(() {
        _answers = messages;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const SlideMenuBar(),
        appBar: const MyAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                widget.message.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Status: ${widget.message.status}"),
                  Row(
                    children: [
                      Text("Rating: ${widget.message.rating}"),
                      const Icon(
                          Icons.star_rate,
                          color: Color.fromRGBO(234, 74, 77, 1),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(
                  color: Color.fromRGBO(246, 140, 141, 1),
                  thickness: 2,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      widget.message.content,
                      style: const TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 140, 141, 1)
                      ),
                      child: LoadingNameText(id: widget.message.id,)
                  )
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        if(_isLiked){
                          setState(() {
                            _isLiked = false;
                            widget.message.rating -= 1;
                          });
                        } else if(_isDisliked){
                          setState(() {
                            _isLiked = true;
                            _isDisliked = false;
                            widget.message.rating += 2;
                          });
                        } else {
                          setState(() {
                            _isLiked = true;
                            widget.message.rating += 1;
                          });
                        }
                      },
                      child: Text(
                          "Rate up",
                          style: TextStyle(
                            color: (_isLiked) ? const Color.fromRGBO(246, 140, 141, 1) : Colors.grey,
                          ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if(_isDisliked){
                          setState(() {
                            _isDisliked = false;
                            widget.message.rating += 1;
                          });
                        } else if(_isLiked){
                          setState(() {
                            _isLiked = false;
                            _isDisliked = true;
                            widget.message.rating -= 2;
                          });
                        } else {
                          setState(() {
                            _isDisliked = true;
                            widget.message.rating -= 1;
                          });
                        }
                      },
                      child: Text(
                          "Rate down",
                          style: TextStyle(
                            color: (_isDisliked) ? const Color.fromRGBO(246, 140, 141, 1) : Colors.grey,
                          ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: (_answers == null) ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(234, 74, 77, 1),
                      )
                  ) : (_answers!.isEmpty) ? Center(
                    child: Text("No answers yet..."),
                  ) : Expanded(
                    child: Wrap(
                      children: [ListView.builder(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(),
                          shrinkWrap: true,

                          padding: const EdgeInsets.all(8),
                          itemCount: _answers!.length,
                          itemBuilder: (BuildContext context, int index){
                            return AnswerMessage(message: _answers![index]);
                          }
                      ),]
                    ),
                  ),
                ),
              ),
              TextField(
                controller: controller,
                cursorColor: const Color.fromRGBO(246, 140, 141, 1),
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(246, 140, 141, 1)),
                    ),
                    hintText: "Add a reply"
                ),
                maxLines: 1,
                maxLength: 30,
                onChanged: (String str){
                  print(str);
                },
              ),

            ],
          ),
        )
    );
  }

}