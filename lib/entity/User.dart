class User{
  String id;
  String name;
  String lastName;
  String type;
  List<String> roles;

  User({required this.id,
    required this.name,
    required this.lastName,
    required this.type,
    required this.roles});

  factory User.fromJson(json){
    String id = (json['user_id']).toString();
    String name = json['user_name'] as String;
    String lastName = json['user_last_name'] as String;
    String type = json['user_type'] as String;

    List<String> roles = List<String>.from(json['roles'].map((model)=> model));

    return User(id: id, name: name, lastName: lastName, type: type, roles: roles);
  }
}