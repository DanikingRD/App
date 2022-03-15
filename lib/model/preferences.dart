class UserPreferences {
  final String uid;
  final String theme;

  const UserPreferences({required this.uid, required this.theme});

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
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
