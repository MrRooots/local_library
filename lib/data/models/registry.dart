import 'package:equatable/equatable.dart';

class RegistryModel extends Equatable {
  final String bookId;
  final int remains;

  /// Constructor
  const RegistryModel({
    required this.bookId,
    required this.remains,
  });

  @override
  List<Object?> get props => [bookId, remains];
}
