class Message {
  String id;
  String title;
  String content;
  String status;
  String authorId;
  String parentId;
  int rating;

  Message({required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.authorId,
    required this.parentId,
    required this.rating});

  factory Message.fromJson(json){
    String id = (json['message_id'] as int).toString();
    String title = json['title'] as String;
    String content = json['content'] as String;
    String status = json['status'].toString();
    String authorId = (json['author_id']).toString();
    String parentId = (json['parent_id']).toString();
    int rating = json['num_of_likes'] as int;
    
    return Message(id: id, title: title, content: content, status: status, authorId: authorId, parentId: parentId, rating: rating);
  }
}