import 'package:flutter/material.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/presentation/pages/book_details/components/body.dart';
import 'package:local_library/presentation/pages/book_details/components/floating_buttons.dart';
import 'package:local_library/presentation/widgets/cart_badge.dart';

class BookDetailsPage extends StatefulWidget {
  final BookEntity book;

  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  BookEntity? _book;

  @override
  Widget build(BuildContext context) {
    final RouteSettings? settings = ModalRoute.of(context)?.settings;
    final bool showCart = settings != null && settings.arguments == true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          splashRadius: 0.1,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 16.0,
          ),
        ),
        actions: [
          if (showCart) const CartBadge(addListener: true),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BookDetailsPageBody(book: _book ?? widget.book),
      ),
      floatingActionButton: FloatingButtons(
        book: _book ?? widget.book,
        showCart: showCart,
        updateBookDataCallback: _updateBookDataCallback,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Callback that updates current book info with given one
  void _updateBookDataCallback(final BookEntity book) =>
      setState(() => _book = book);
}
