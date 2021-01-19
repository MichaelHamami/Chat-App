class User {
    final String username;
    final String password;
  
    User({this.username, this.password});
  
    factory User.fromJson(Map<String, dynamic> json) {
  
      return User(
        username: json['username'],
        password: json['password'],
      );
    }
  }