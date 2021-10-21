
class UserModel {
  int id;
  String email;
  
  UserModel({
    required this.id,
    required this.email,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
