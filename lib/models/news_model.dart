import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  const NewsModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.date,
  });

  final String? id;
  final String? image;
  final String? title;
  final String? description;
  final DateTime? date;

  factory NewsModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    final rawDate = data['createdAt'] ?? data['date'];
    DateTime? parsedDate;
    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate != null) {
      parsedDate = DateTime.tryParse(rawDate.toString());
    }

    return NewsModel(
      id: doc.id,
      image: (data['imageUrl'] ?? data['image']) as String?,
      title: data['title'] as String?,
      description: (data['description'] ?? data['body']) as String?,
      date: parsedDate,
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String?,
      image: (json['imageUrl'] ?? json['image']) as String?,
      title: json['title'] as String?,
      description: (json['description'] ?? json['body']) as String?,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': image,
        'title': title,
        'description': description,
        'date': date?.toIso8601String(),
      };
}
