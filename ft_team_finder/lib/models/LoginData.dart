class LoginData {
  String email = "";
  String password = "";

  set setEmail(input) => this.email = input;
  set setPassword(input) => this.password = input;

  LoginData({this.email, this.password});

  LoginData.fromMap(map) {
    this.email = map["email"];
    this.password = map["password"];
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["email"] = this.email;
    map["password"] = this.password;
    return map;
  }
}
