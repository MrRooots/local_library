import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String path;

  const ImageEntity({required this.path});

  @override
  List<Object?> get props => [path];
}
