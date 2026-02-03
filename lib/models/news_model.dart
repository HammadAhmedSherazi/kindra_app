class NewsModel {
  const NewsModel({
    this.image,
    this.title,
    this.description,
    this.date,
  });

  final String? image;
  final String? title;
  final String? description;
  final DateTime? date;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'description': description,
        'date': date?.toIso8601String(),
      };
}
