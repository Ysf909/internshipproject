class Expert {
  final String id;
  final String name;
  final String title;
  final String company;
  final int experienceYears;
  final List<String> specializations;
  final String bio;
  final String imageUrl;
  final double rating;
  final int totalStudents;
  final List<String> programIds;
  final String linkedIn;

  const Expert({
    required this.id,
    required this.name,
    required this.title,
    required this.company,
    required this.experienceYears,
    required this.specializations,
    required this.bio,
    required this.imageUrl,
    required this.rating,
    required this.totalStudents,
    required this.programIds,
    this.linkedIn = '',
  });

  factory Expert.fromJson(Map<String, dynamic> json) => Expert(
        id: json['id'] as String,
        name: json['name'] as String,
        title: json['title'] as String,
        company: json['company'] as String,
        experienceYears: json['experienceYears'] as int,
        specializations: List<String>.from(json['specializations'] as List),
        bio: json['bio'] as String,
        imageUrl: json['imageUrl'] as String,
        rating: (json['rating'] as num).toDouble(),
        totalStudents: json['totalStudents'] as int,
        programIds: List<String>.from(json['programIds'] as List),
        linkedIn: json['linkedIn'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'company': company,
        'experienceYears': experienceYears,
        'specializations': specializations,
        'bio': bio,
        'imageUrl': imageUrl,
        'rating': rating,
        'totalStudents': totalStudents,
        'programIds': programIds,
        'linkedIn': linkedIn,
      };
}
