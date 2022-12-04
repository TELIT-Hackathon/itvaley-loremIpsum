class Type{
  String id;
  String name;

  Type({required this.id,
    required this.name});

  factory Type.fromJson(json){
    String id = (json['type_id'] as int).toString();
    String name = json['user_type'] as String;

    return Type(id: id, name: name);
  }
}