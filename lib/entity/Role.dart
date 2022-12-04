class Role {
  String title;

  Role({required this.title});

  factory Role.fromJson(json){
    String title = json['title'] as String;

    return Role(title: title);
  }
}