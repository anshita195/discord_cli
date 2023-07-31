// models/user.dart

class User {
  final String username;
  bool isLoggedIn;

  User(this.username, {this.isLoggedIn = false});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'isLoggedIn': isLoggedIn,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      isLoggedIn: json['isLoggedIn'] ?? false,
    );
  }
}
