import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/pages/cart/components/dismissible_cart_item.dart';
import 'package:local_library/presentation/pages/cart/components/hint_cart_item.dart';

class CartBooksList extends StatelessWidget {
  const CartBooksList({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerEntity customer =
        BlocProvider.of<AuthenticationBloc>(context).getCustomer;
    final List<BookEntity> books =
        BlocProvider.of<CustomerCartBloc>(context).books;

    return ListView.builder(
      itemCount: books.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index < books.length
            ? DismissibleCartItem(book: books[index], customer: customer)
            : const HintCartItem();
      },
    );
  }
}
