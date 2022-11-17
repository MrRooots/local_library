import 'package:equatable/equatable.dart';

class RegistryEntity extends Equatable {
  final String bookId;
  final int remains;

  /// Constructor
  const RegistryEntity({
    required this.bookId,
    required this.remains,
  });

  @override
  List<Object?> get props => [bookId, remains];
}
