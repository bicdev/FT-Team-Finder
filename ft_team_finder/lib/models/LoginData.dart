class LoginData {
  String email;
  String password;
  bool isValidated = false;

  printCredentials() {
    //for debugging purposes only
    print("Username: $email");
    print("Password: $password");
  }

  bool validate(){ //will check for email
    return true;
  }
}
