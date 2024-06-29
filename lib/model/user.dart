class UserLocal {
  String? name;
  String? email;
  String? id;
  String? photo;
  String ? role;
  UserLocal(this.name, this.email, this.id, this.photo, this.role);

  Map<String, dynamic> toFireStore() {

    return {
      'id': id, 'name': name, 'email': email,
      'photo': photo,
      'role': role
    };
  }

  UserLocal.fromFireStore(Map<String, dynamic>? mp) {
    id=mp?['id'];
    name=mp?['name'];
    email=mp?['email'];
    photo=mp?['photo'];
    role=mp?['role'];
  }

}
