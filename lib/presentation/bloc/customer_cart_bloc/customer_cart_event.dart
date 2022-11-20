part of 'customer_cart_bloc.dart';

abstract class CustomerCartEvent extends Equatable {
  const CustomerCartEvent();

  @override
  List<Object> get props => [];
}

/// Add given [book] to customer cart
class AddBookToCart extends CustomerCartEvent {
  final BookEntity book;
  final CustomerEntity customer;

  const AddBookToCart({required this.book, required this.customer});
}

/// Remove given [book] from customer cart
class RemoveBookFromCart extends CustomerCartEvent {
  final BookEntity book;
  final CustomerEntity customer;

  const RemoveBookFromCart({required this.book, required this.customer});
}

/// Try to restore the customer cart from database
class RestoreCustomerCart extends CustomerCartEvent {
  final CustomerEntity customer;

  const RestoreCustomerCart({required this.customer});
}
