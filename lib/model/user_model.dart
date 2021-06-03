class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  bool prime = false;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory Data.fromJSON(Map<String, dynamic> jsonMap) {
    return Data(
        id: jsonMap['id'],
        email: jsonMap['email'],
        firstName: jsonMap['first_name'],
        lastName: jsonMap['last_name'],
        avatar: jsonMap['avatar']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "avatar": this.avatar
    };
  }
}
