import 'package:flutter/material.dart';
import 'package:it_valey_hackathon_2022/entity/Message.dart';

import '../pages/TopicPage.dart';
import 'LoadingNameText.dart';

class AnswerMessage extends StatefulWidget{
  final Message message;

  const AnswerMessage({super.key, required this.message});

  @override
  State<StatefulWidget> createState() => _AnswerMessage();
}

class _AnswerMessage extends State<AnswerMessage>{
  bool _isLiked = false;
  bool _isDisliked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TopicPage(message: widget.message))
        );
      },
      child: Card(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        widget.message.content,
                        style: const TextStyle(
                            fontSize: 18
                        )
                    )
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
                      ),
                      Text(
                        widget.message.rating.toString(),
                        style: TextStyle(
                          color: (widget.message.rating == 0) ? Colors.grey :
                                    (widget.message.rating < 0) ? Colors.red : Colors.green
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}