class User {
  late int id;
  late String username;
  late String email;

  User(this.id, this.username, this.email);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': username,
      'email': email,
    };
  }
}
