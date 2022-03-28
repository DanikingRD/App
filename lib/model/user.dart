class TapeaUser {
  final String uid;
  final String username;
  final String email;
  final String? avatarURL;
  final int profiles;

  const TapeaUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarURL,
    required this.profiles,
  });

  factory TapeaUser.fromJson(Map<String, dynamic> json) {
    return TapeaUser(
      uid: json["uid"],
      username: json["username"],
      email: json["email"],
      avatarURL: json["avatarURL"],
      profiles: json["profiles"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "avatarURL": avatarURL,
      "profiles": profiles,
    };
  }

  @override
  String toString() {
    return 'TapeaUser(uid: $uid, username: $username, email: $email, avatarURL: $avatarURL, devices: $profiles)';
  }
}
