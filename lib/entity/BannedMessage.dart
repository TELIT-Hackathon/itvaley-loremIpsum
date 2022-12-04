class BannedMessage{
  String messageId;
  String userId;

  BannedMessage({required this.messageId,
    required this.userId});

  factory BannedMessage.fromJson(json){
    String messageId = (json['message_id'] as int).toString();
    String userId = (json['user_id'] as int).toString();

    return BannedMessage(messageId: messageId, userId: userId);
  }
}