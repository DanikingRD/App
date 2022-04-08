
class TapeaCard {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photo;

  TapeaCard({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photo,
  });

  factory TapeaCard.fromJson(Map<String, dynamic> json) {
    return TapeaCard(
      title: json["title"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      jobTitle: json["header"],
      company: json["subtitle"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "firstName": firstName,
      "lastName": lastName,
      "header": jobTitle,
      "subtitle": company,
      "photo": photo,
    };
  }


  @override
  String toString() {
    return 'TapeaCard(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company photo: $photo)';
  }
}
