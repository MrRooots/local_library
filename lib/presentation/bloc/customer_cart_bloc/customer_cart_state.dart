part of 'customer_cart_bloc.dart';

abstract class CustomerCartState extends Equatable {
  final List<BookEntity> books;

  const CustomerCartState({this.books = const []});

  /// Get count of [BookEntity] in cart
  int get booksCount => books.length;

  @override
  List<Object> get props => [books, books.length];
}

/// Initial state of cart
class CustomerCartInitial extends CustomerCartState {
  const CustomerCartInitial();
}

/// Customer cart with all books
class CustomerCartCurrent extends CustomerCartState {
  const CustomerCartCurrent({required final List<BookEntity> books})
      : super(books: books);
}

/// Cart is loading
class CustomerCartLoading extends CustomerCartState {
  const CustomerCartLoading({required final List<BookEntity> books})
      : super(books: books);
}

/// There is no any books remains
class CustomerCartNoBooksRemains extends CustomerCartState {
  const CustomerCartNoBooksRemains();
}
