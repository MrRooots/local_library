import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/pages/book_management/book_management.dart';

class FloatingButtons extends StatelessWidget {
  final BookEntity book;

  final bool showCart;

  final void Function(BookEntity) updateBookDataCallback;

  const FloatingButtons({
    super.key,
    required this.book,
    required this.showCart,
    required this.updateBookDataCallback,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerEntity customer =
        BlocProvider.of<AuthenticationBloc>(context).getCustomer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (BlocProvider.of<AuthenticationBloc>(context).isAdmin)
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Palette.red,
              onPressed: () => _editBook(context),
              tooltip: 'Edit this book',
              child: const Icon(Icons.admin_panel_settings_outlined),
            ),
          if (showCart)
            BlocBuilder<CustomerCartBloc, CustomerCartState>(
              builder: (context, state) {
                Widget buttonIcon;
                final bool isBookInCart =
                    BlocProvider.of<CustomerCartBloc>(context)
                        .isBookInCart(book: book);

                if (state is CustomerCartCurrent) {
                  buttonIcon = isBookInCart
                      ? const Icon(Icons.remove_shopping_cart_outlined)
                      : const Icon(Icons.add_shopping_cart_rounded);
                } else if (state is CustomerCartLoading) {
                  buttonIcon =
                      const CircularProgressIndicator(color: Colors.white);
                } else {
                  buttonIcon = const Icon(Icons.error_outline_rounded);
                }

                return FloatingActionButton(
                  heroTag: null,
                  tooltip: isBookInCart ? 'Remove from cart' : 'Add to cart',
                  onPressed: () => isBookInCart
                      ? BlocProvider.of<CustomerCartBloc>(context).add(
                          RemoveBookFromCart(book: book, customer: customer))
                      : BlocProvider.of<CustomerCartBloc>(context)
                          .add(AddBookToCart(book: book, customer: customer)),
                  child: buttonIcon,
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _editBook(final BuildContext context) async {
    final BookEntity? value = await Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => BookManagementPage(book: book)),
    );

    if (value != null) {
      updateBookDataCallback(value);
    }
  }
}
