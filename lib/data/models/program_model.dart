class Program {
  final String id;
  final String title;
  final String category;
  final String duration;
  final double price;
  final String imageUrl;
  final String description;
  final String expertId;
  final List<String> outcomes;
  final String level;
  final double rating;
  final int totalStudents;
  final bool isFeatured;
  final String startDate;
  final List<String> tags;
  // 'course' | 'degree' | 'certificate'
  final String programType;
  // For degrees: 'Bachelor\'s' | 'Master\'s' | 'MBA' | null
  final String? degreeType;
  // ECTS credits for accredited programs
  final int? ects;
  // SDG goals this program contributes to
  final List<String> sdgGoals;

  const Program({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.expertId,
    required this.outcomes,
    required this.level,
    required this.rating,
    required this.totalStudents,
    this.isFeatured = false,
    required this.startDate,
    required this.tags,
    this.programType = 'course',
    this.degreeType,
    this.ects,
    this.sdgGoals = const [],
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json['id'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        duration: json['duration'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String,
        description: json['description'] as String,
        expertId: json['expertId'] as String,
        outcomes: List<String>.from(json['outcomes'] as List),
        level: json['level'] as String,
        rating: (json['rating'] as num).toDouble(),
        totalStudents: json['totalStudents'] as int,
        isFeatured: json['isFeatured'] as bool? ?? false,
        startDate: json['startDate'] as String,
        tags: List<String>.from(json['tags'] as List),
        programType: json['programType'] as String? ?? 'course',
        degreeType: json['degreeType'] as String?,
        ects: json['ects'] as int?,
        sdgGoals: json['sdgGoals'] != null
            ? List<String>.from(json['sdgGoals'] as List)
            : const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'duration': duration,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
        'expertId': expertId,
        'outcomes': outcomes,
        'level': level,
        'rating': rating,
        'totalStudents': totalStudents,
        'isFeatured': isFeatured,
        'startDate': startDate,
        'tags': tags,
        'programType': programType,
        'degreeType': degreeType,
        'ects': ects,
        'sdgGoals': sdgGoals,
      };

  String get formattedPrice =>
      price == 0 ? 'Free' : '\$${price.toStringAsFixed(0)}';

  bool get isDegree => programType == 'degree';
  bool get isCourse => programType == 'course';
}
