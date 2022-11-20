import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/usecases/book/update_book.dart';

part 'update_book_event.dart';
part 'update_book_state.dart';

class UpdateBookBloc extends Bloc<UpdateBookEvent, UpdateBookState> {
  final UpdateBookUseCase updateBook;

  UpdateBookBloc({required this.updateBook})
      : super(const UpdateBookInitial()) {
    on<UpdateBook>(_onUpdate);
  }

  Future<void> _onUpdate(
    final UpdateBook event,
    final Emitter<UpdateBookState> emit,
  ) async {
    emit(const UpdateBookLoading());

    final successOrFailure = await updateBook(
      UpdateBookParams(newBok: event.newBook),
    );

    successOrFailure.fold(
      (_) => emit(const UpdateBookSuccessful()),
      (final Failure failure) => emit(UpdateBookFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }
}
