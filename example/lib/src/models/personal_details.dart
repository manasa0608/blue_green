class PersonalDetails {
  late String name;
  late String email;

  PersonalDetails(this.name, this.email);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  static PersonalDetails fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String email = json['email'];

    return PersonalDetails(name, email);
  }
}
