import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/repositories/book_repository.dart';

part 'customer_cart_state.dart';

class CustomerCartCubit extends Cubit<CustomerCartState> {
  final BookRepository repository;
  CustomerCartCubit({required this.repository})
      : super(const CustomerCartState());

  /// Get [BookEntity] that has been added to cart
  List<BookEntity> get selectedBooks => state.books;

  /// Get the count of [BookEntity] inside customer cart
  int get selectedBooksCount => state.booksCount;

  /// Add new [BookEntity] to cart
  Future<void> addBookToCart({required final BookEntity book}) async {
    final List<BookEntity> books = state.books;
    final remainOrFailure = await repository.checkAvailability(bookId: book.id);

    remainOrFailure.fold(
      (final bool isBookRemains) {
        if (isBookRemains) {
          emit(CustomerCartState(books: [...books, book]));
        } else {
          emit(const CustomerCartNoBooksRemains());
          emit(CustomerCartState(books: [...books]));
        }
      },
      (final Failure failure) => print(failure),
    );
  }

  /// Remove [BookEntity] from cart
  Future<void> removeBookFromCart({required final BookEntity book}) async {
    final List<BookEntity> books = state.books;

    emit(CustomerCartState(
      books: List.of(books)
        ..removeWhere((final BookEntity bk) => book.id == bk.id),
    ));
  }

  /// Check if given [book] is already in cart
  bool isBookInCart({required final BookEntity book}) {
    return selectedBooks
        .where((final BookEntity bk) => bk.id == book.id)
        .isNotEmpty;
  }
}
