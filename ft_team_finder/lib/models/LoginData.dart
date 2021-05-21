class LoginData {
  String email = "";
  String password = "";
  bool isValidated = false;

  set setEmail(input) => this.email = input;
  set setPassword(input) => this.password = input;

  printCredentials() {
    //for debugging purposes only
    print("Username: $email");
    print("Password: $password");
  }

  bool validate() {
    //placeholder
    //will check for email
    return true;
  }
}
