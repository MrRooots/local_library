part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {
  const ImageInitial();
}

class ImageLoading extends ImageState {
  const ImageLoading();
}

class ImageLoadingSuccessful extends ImageState {
  final File image;

  const ImageLoadingSuccessful({required this.image});

  @override
  List<Object> get props => [image];
}

class ImageLoadingFailed extends ImageState {
  const ImageLoadingFailed();
}
