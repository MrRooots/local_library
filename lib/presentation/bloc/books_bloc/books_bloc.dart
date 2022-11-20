import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/usecases/book/load_books.dart';
import 'package:local_library/domain/usecases/book/update_book.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final LoadBooks loadBooks;

  int limit = 0;

  BooksBloc({required this.loadBooks}) : super(const BooksEmpty()) {
    on<LoadBooksEvent>(_onFetching);
    on<ReloadBooksEvent>(_onReload);
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

    emit(BooksLoading(oldBooks: oldBooks, isFirstFetch: limit == 0));

    final failureOrCharacters = await loadBooks(
      LoadBooksParams(
        offset: 10 * limit,
        limit: 10,
      ),
    );

    failureOrCharacters.fold(
      (final List<BookEntity> books) {
        if (books.isNotEmpty) limit++;
        emit(BooksLoadingSuccessful(books: [...oldBooks, ...books]));
      },
      (final Failure failure) => emit(BooksLoadingFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }

  Future<void> _onReload(
    final ReloadBooksEvent event,
    final Emitter<BooksState> emit,
  ) async {
    print('Reloading books');
    emit(const BooksLoading(oldBooks: []));

    final failureOrCharacters = await loadBooks(const LoadBooksParams());

    failureOrCharacters.fold(
      (final List<BookEntity> books) {
        if (books.isNotEmpty && limit == 0) limit++;
        emit(BooksLoadingSuccessful(books: [...books]));
      },
      (final Failure failure) => emit(BooksLoadingFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }
}
