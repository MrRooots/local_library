import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:local_library/domain/entities/book_entity.dart';

import 'package:local_library/presentation/pages/book_details/book_details.dart';

class BookCard extends StatelessWidget {
  final bool showCart;
  final BookEntity book;

  const BookCard({super.key, required this.book, this.showCart = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => BookDetailsPage(book: book),
        settings: RouteSettings(arguments: showCart),
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
                  Expanded(flex: 2, child: _buildInfoBlock(context)),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/img/book_placeholder.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildInfoBlock(context) {
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
}
