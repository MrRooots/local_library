import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final DateTime publishedAt;

  /// Constructor
  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [id, title, author, publisher, publishedAt];
}
