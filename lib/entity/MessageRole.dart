class MessageRole{
  String id;
  String messageId;
  String roleId;

  MessageRole({required this.id,
    required this.messageId,
    required this.roleId});

  factory MessageRole.fromJson(json){
    String id = (json['id_row'] as int).toString();
    String messageId = (json['message_id'] as int).toString();
    String roleId = (json['role_id'] as int).toString();

    return MessageRole(id: id, messageId: messageId, roleId: roleId);
  }
}