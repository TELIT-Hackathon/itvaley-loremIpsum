class Role {
  String id;
  String title;

  Role({required this.id,
    required this.title});

  factory Role.fromJson(json){
    String id = (json['role_id'] as int).toString();
    String title = json['title'] as String;

    return Role(id: id, title: title);
  }
}