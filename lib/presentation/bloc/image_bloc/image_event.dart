part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class LoadExistingImage extends ImageEvent {
  const LoadExistingImage();

  @override
  List<Object> get props => [];
}

class SelectImageFromGallery extends ImageEvent {
  const SelectImageFromGallery();

  @override
  List<Object> get props => [];
}
