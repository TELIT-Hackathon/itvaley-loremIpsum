class UserRole{
  String id;
  String userId;
  String roleId;

  UserRole({required this.id,
    required this.userId,
    required this.roleId});

  factory UserRole.fromJson(json){
    String id = (json['id_row'] as int).toString();
    String userId = (json['user_id'] as int).toString();
    String roleId = (json['role_id'] as int).toString();
    
    return UserRole(id: id, userId: userId, roleId: roleId);
  }
}