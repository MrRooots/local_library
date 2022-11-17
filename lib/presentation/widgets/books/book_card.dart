import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/domain/entities/book_entity.dart';

import 'package:local_library/presentation/bloc/customer_cart_cubit/customer_cart_cubit.dart';

import 'package:local_library/presentation/widgets/books/book_details.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      )),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoBlock(),
                  BlocBuilder<CustomerCartCubit, CustomerCartState>(
                    builder: (context, state) {
                      return _buildCartIcon(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildInfoBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(book.author, style: const TextStyle(fontSize: 16.0)),
        Text(
          book.title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(book.publisher, style: const TextStyle(fontSize: 16.0)),
        Text('Published: ${DateFormat.yMMMMd().format(book.publishedAt)}'),
      ],
    );
  }

  Padding _buildCartIcon(final BuildContext context) {
    final bool isBookInCart =
        BlocProvider.of<CustomerCartCubit>(context).isBookInCart(book: book);

    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: IconButton(
        onPressed: () => isBookInCart
            ? BlocProvider.of<CustomerCartCubit>(context)
                .removeBookFromCart(book: book)
            : BlocProvider.of<CustomerCartCubit>(context)
                .addBookToCart(book: book),
        icon: isBookInCart
            ? const Icon(Icons.remove_shopping_cart_rounded,
                color: Palette.lightOrange)
            : const Icon(Icons.shopping_cart_rounded,
                color: Palette.lightGreenSalad),
      ),
    );
  }
}
