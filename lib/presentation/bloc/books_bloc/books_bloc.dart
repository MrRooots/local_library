import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/usecases/book/load_books.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final LoadBooks loadBooks;
  int page = 1;

  BooksBloc({required this.loadBooks}) : super(const BooksEmpty()) {
    on<LoadBooksEvent>(_onFetching);
  }

  Future<void> _onFetching(
    final LoadBooksEvent event,
    final Emitter<BooksState> emit,
  ) async {
    if (state is BooksLoading) {
      return;
    }

    List<BookEntity> oldBooks = [];

    if (state is BooksLoadingSuccessful) {
      oldBooks = (state as BooksLoadingSuccessful).books;
    }

    emit(
      BooksLoading(oldBooks: oldBooks, isFirstFetch: page == 1),
    );

    final failureOrCharacters = await loadBooks(const LoadBooksParams());

    failureOrCharacters.fold(
      (final List<BookEntity> books) {
        page++;

        emit(BooksLoadingSuccessful(books: [...books]));
      },
      (final Failure failure) => emit(BooksLoadingFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }
}
