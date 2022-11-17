import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/data/models/image.dart';

import 'package:local_library/domain/repositories/image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;
  ImageBloc({required this.repository}) : super(const ImageInitial()) {
    on<LoadExistingImage>(_loadImage);
    on<SelectImageFromGallery>(_selectImage);
  }

  /// Load selected image from local storage
  Future<void> _loadImage(
    final LoadExistingImage event,
    final Emitter<ImageState> emit,
  ) async {
    print('Loading image');
    final imageOrFailure = await repository.getCustomerImage();

    imageOrFailure.fold(
      (final File path) => emit(ImageLoadingSuccessful(image: path)),
      (final Failure failure) => emit(const ImageLoadingFailed()),
    );
    print('Loading image state: $state');
  }

  /// Select image using [ImagePicker] from gallery
  Future<void> _selectImage(
    final SelectImageFromGallery event,
    final Emitter<ImageState> emit,
  ) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      emit(const ImageLoading());
      final imageOrFailure = await repository.saveImageToCache(image: image);

      imageOrFailure.fold(
        (final ImageModel image) {
          print(image);
          return emit(ImageLoadingSuccessful(image: image.imageFile));
        },
        (final Failure failure) {
          print('Failed: $failure');
          return emit(const ImageLoadingFailed());
        },
      );
    }
  }
}
