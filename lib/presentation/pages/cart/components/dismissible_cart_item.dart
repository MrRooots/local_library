import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/pages/books_list/components/book_card.dart';

class DismissibleCartItem extends StatelessWidget {
  final CustomerEntity customer;
  final BookEntity book;

  const DismissibleCartItem({
    super.key,
    required this.book,
    required this.customer,
  });

  @override
  Dismissible build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) async => await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm', textAlign: TextAlign.center),
            content: Text(
              'Are you sure you wish to remove "${book.title}" book from cart?',
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.red,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Remove")),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.lightGreenSalad,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ],
          );
        },
      ),
      key: ValueKey(book.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => BlocProvider.of<CustomerCartBloc>(context)
          .add(RemoveBookFromCart(book: book, customer: customer)),
      child: BookCard(book: book, showCart: false),
    );
  }
}
