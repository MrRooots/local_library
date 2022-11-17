import 'package:equatable/equatable.dart';

import 'package:local_library/data/models/request.dart';
import 'package:local_library/data/models/staff.dart';

class ServiceModel extends Equatable {
  final String id;
  final String name;
  final RequestModel request;
  final StaffModel staff;

  /// Constructor
  const ServiceModel({
    required this.id,
    required this.name,
    required this.request,
    required this.staff,
  });

  @override
  List<Object?> get props => [id, name, request, staff];
}
