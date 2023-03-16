class User {
  final String email;
  final String fullName;
  final String avatarUrl;

  User({required this.email, required this.fullName, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      fullName: '${json['first_name']} ${json['last_name']}',
      avatarUrl: json['avatar'],
    );
  }
}