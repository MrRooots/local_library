import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final String id;
  final String name;
  final String surname;
  final String phone;

  /// Constructor
  const StaffModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, surname, phone];
}
