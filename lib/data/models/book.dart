import 'package:local_library/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  /// Constructor
  const BookModel({
    required final int id,
    required final String title,
    required final String author,
    required final String publisher,
    required final DateTime publishedAt,
  }) : super(
          id: id,
          title: title,
          author: author,
          publisher: publisher,
          publishedAt: publishedAt,
        );

  /// Create [BookModel] from given [json]
  factory BookModel.fromJson({required final Map<String, dynamic> json}) =>
      BookModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        publisher: json['publisher'],
        publishedAt: DateTime.parse(json['published_at']),
      );

  /// Convert [BookModel] to json format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'published_at': publishedAt.toIso8601String(),
    };
  }

  /// Copy current [BookModel] with given parameters
  BookModel copyWith({
    int? id,
    String? title,
    String? author,
    String? publisher,
    DateTime? publishedAt,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
