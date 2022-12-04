class Status {
  String id;
  String name;

  Status({required this.id,
    required this.name});

  factory Status.fromJson(json){
    String id = (json['status_id'] as int).toString();
    String name = json['status_name'] as String;

    return Status(id: id, name: name);
  }
}