import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/usecases/book/add_book_to_cart.dart';
import 'package:local_library/domain/usecases/book/check_availability.dart';
import 'package:local_library/domain/usecases/book/remove_book_from_cart.dart';
import 'package:local_library/domain/usecases/cart/get_customer_cart.dart';

part 'customer_cart_event.dart';
part 'customer_cart_state.dart';

class CustomerCartBloc extends Bloc<CustomerCartEvent, CustomerCartState> {
  final CheckAvailabilityUseCase checkAvailability;
  final AddBookToCartUseCase addBookToCart;
  final LoadCustomerCartUseCase loadCustomerCart;
  final RemoveBookFromCartUseCase removeBookFromCart;

  /// Get [BookEntity] that has been added to cart
  List<BookEntity> get books => state.books;

  /// Get the count of [BookEntity] inside customer cart
  int get booksCount => state.booksCount;

  CustomerCartBloc({
    required this.checkAvailability,
    required this.addBookToCart,
    required this.removeBookFromCart,
    required this.loadCustomerCart,
  }) : super(const CustomerCartInitial()) {
    on<AddBookToCart>(_addBookToCart);
    on<RemoveBookFromCart>(_removeBookFromCart);
    on<RestoreCustomerCart>(_restoreCustomerCart);
  }

  /// Add new [BookEntity] to current cart
  Future<void> _addBookToCart(
    final AddBookToCart event,
    final Emitter<CustomerCartState> emit,
  ) async {
    final List<BookEntity> books = state.books;

    emit(CustomerCartLoading(books: books));

    final remainOrFailure = await checkAvailability(
      CheckAvailabilityParams(bookId: event.book.id),
    );

    remainOrFailure.fold(
      (final bool isBookRemains) async {
        if (isBookRemains) {
          addBookToCart(AddBookToCartParams(
            customer: event.customer,
            request: event.customer.request,
            book: event.book,
          ));
          emit(CustomerCartCurrent(books: [...books, event.book]));
        } else {
          emit(const CustomerCartNoBooksRemains());
          emit(CustomerCartCurrent(books: [...books]));
        }
      },
      (final Failure failure) => print('Adding failed: $failure'),
    );
  }

  /// Remove [BookEntity] from cart
  Future<void> _removeBookFromCart(
    final RemoveBookFromCart event,
    final Emitter<CustomerCartState> emit,
  ) async {
    await removeBookFromCart(RemoveBookFromCartParams(
      customer: event.customer,
      request: event.customer.request,
      book: event.book,
    ));

    final List<BookEntity> books = state.books;

    emit(CustomerCartCurrent(
      books: List.of(books)
        ..removeWhere((final BookEntity bk) => event.book.id == bk.id),
    ));
  }

  /// Check if given [book] is already in cart
  bool isBookInCart({required final BookEntity book}) {
    return books.where((final BookEntity bk) => bk.id == book.id).isNotEmpty;
  }

  /// Restore customer cart from database or return the empty one
  Future<void> _restoreCustomerCart(
    final RestoreCustomerCart event,
    final Emitter<CustomerCartState> emit,
  ) async {
    print('Cart is updating');
    emit(CustomerCartLoading(books: books));

    final cartOrFailure = await loadCustomerCart(
      LoadCustomerCartParams(customer: event.customer),
    );

    cartOrFailure.fold(
      (final List<BookEntity> books) => emit(CustomerCartCurrent(books: books)),
      (r) => emit(CustomerCartCurrent(books: event.customer.request.books)),
    );
    print('Cart has been updated');
  }
}
