class TapeaUser {
  final String uid;
  final String username;
  final String email;
  final String? avatarURL;
  final int devices;

  const TapeaUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarURL,
    required this.devices,
  });

  factory TapeaUser.fromJson(Map<String, dynamic> json) {
    return TapeaUser(
      uid: json["uid"],
      username: json["username"],
      email: json["email"],
      avatarURL: json["avatarURL"],
      devices: json["devices"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "avatarURL": avatarURL,
      "devices": devices,
    };
  }

  @override
  String toString() {
    return 'TapeaUser(uid: $uid, username: $username, email: $email, avatarURL: $avatarURL, devices: $devices)';
  }
}
