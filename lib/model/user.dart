class TapeaUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String? avatarURL;
  final int profiles;
  final String defaultProfile;

  const TapeaUser({
    required this.firstName,
    required this.lastName,
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarURL,
    required this.profiles,
    required this.defaultProfile,
  });

  factory TapeaUser.fromJson(Map<String, dynamic> json) {
    return TapeaUser(
      firstName: json["firstName"],
      lastName: json["lastName"],
      uid: json["uid"],
      username: json["username"],
      email: json["email"],
      avatarURL: json["avatarURL"],
      profiles: json["profiles"],
      defaultProfile: json["defaultProfile"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "uid": uid,
      "username": username,
      "email": email,
      "avatarURL": avatarURL,
      "profiles": profiles,
      "defaultProfile": defaultProfile
    };
  }

  @override
  String toString() {
    return 'TapeaUser(uid: $uid, username: $username, email: $email, avatarURL: $avatarURL, devices: $profiles, defaultProfile: $defaultProfile)';
  }
}
