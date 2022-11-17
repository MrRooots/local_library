import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_cubit/customer_cart_cubit.dart';
import 'package:local_library/presentation/pages/cart.dart';
import 'package:local_library/presentation/pages/search.dart';
import 'package:local_library/presentation/widgets/books/book_card.dart';

class BooksPageBody extends StatelessWidget {
  const BooksPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliable Books'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const BookSearchPage(),
            ),
          ),
          icon: const Icon(Icons.search, color: Palette.lightGreenSalad),
        ),
        actions: [
          BlocConsumer<CustomerCartCubit, CustomerCartState>(
            listener: (context, state) {
              if (state is CustomerCartNoBooksRemains) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    duration: const Duration(seconds: 2),
                    content: AwesomeSnackbarContent(
                      color: Palette.red,
                      title: 'This book is out of stock!',
                      message:
                          'Sorry, but the requested book is currently unavailable',
                      contentType: ContentType.failure,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Badge(
                animationType: BadgeAnimationType.slide,
                position: BadgePosition.topEnd(top: 0, end: -5),
                badgeContent: Text(
                  '${state.booksCount}',
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  splashRadius: 0.1,
                  onPressed: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const CustomerCartPage(),
                    ),
                  ),
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Palette.lightGreenSalad,
                    // size: 18.0,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoadingSuccessful) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.books.length,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(book: state.books[index]);
              },
            );
          } else if (state is BooksLoading) {
            return const Center(
              child: SpinKitSpinningLines(color: Palette.lightGreenSalad),
            );
          } else if (state is BooksLoadingFailed) {
            return Center(
              child: Text('Loading failed!\n${state.errorMessage}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showBottomSheet(final BuildContext context) {
    const items = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    items[index].toString(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
