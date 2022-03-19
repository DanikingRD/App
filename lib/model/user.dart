class TapeaUser {
  final String uid;
  final String username;
  final String email;
  final String? avatarURL;

  const TapeaUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarURL,
  });

  factory TapeaUser.fromJson(Map<String, dynamic> json) {
    return TapeaUser(
      uid: json["uid"],
      username: json["username"],
      email: "email",
      avatarURL: "avatarURL",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "avatarURL": avatarURL,
    };
  }

  @override
  String toString() {
    return 'TapeaUser(uid: $uid, username: $username, email: $email, avatarURL: $avatarURL)';
  }
}
