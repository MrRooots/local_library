part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksEmpty extends BooksState {
  const BooksEmpty();
}

class BooksLoading extends BooksState {
  final bool isFirstFetch;
  final List<BookEntity> oldBooks;

  const BooksLoading({
    this.isFirstFetch = false,
    required this.oldBooks,
  });

  @override
  List<Object> get props => [isFirstFetch, oldBooks];
}

class BooksLoadingSuccessful extends BooksState {
  final List<BookEntity> books;

  const BooksLoadingSuccessful({required this.books});

  @override
  List<Object> get props => [books];
}

class BooksLoadingFailed extends BooksState {
  final String errorMessage;

  const BooksLoadingFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
