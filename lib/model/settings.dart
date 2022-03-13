class UserSettings {
  final String uid;
  final String theme;

  const UserSettings({required this.uid, required this.theme});

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      uid: json["uid"],
      theme: json["theme"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "theme": theme,
    };
  }
}
