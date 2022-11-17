part of 'customer_cart_cubit.dart';

class CustomerCartState extends Equatable {
  final List<BookEntity> books;

  const CustomerCartState({this.books = const []});

  /// Get count of [BookEntity] in cart
  int get booksCount => books.length;

  @override
  List<Object> get props => [books, books.length];
}

class CustomerCartNoBooksRemains extends CustomerCartState {
  const CustomerCartNoBooksRemains();
}
