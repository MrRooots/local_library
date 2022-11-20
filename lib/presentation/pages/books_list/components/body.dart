import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/bloc/update_book_bloc/update_book_bloc.dart';
import 'package:local_library/presentation/pages/book_management/book_management.dart';
import 'package:local_library/presentation/pages/books_list/components/book_card.dart';
import 'package:local_library/presentation/pages/search.dart';
import 'package:local_library/presentation/widgets/cart_badge.dart';
import 'package:local_library/presentation/widgets/load_more_widget.dart';

class BooksPageBody extends StatefulWidget {
  const BooksPageBody({super.key});

  @override
  State<BooksPageBody> createState() => _BooksPageBodyState();
}

class _BooksPageBodyState extends State<BooksPageBody> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _controller.animateTo(
              _controller.position.minScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: const Text('Books'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const BookSearchPage()),
          ),
          icon: const Icon(Icons.search, color: Palette.lightGreenSalad),
        ),
        actions: const [
          CartBadge(),
          SizedBox(width: 10),
        ],
      ),
      body: BlocListener<UpdateBookBloc, UpdateBookState>(
        listener: (context, state) {
          if (state is UpdateBookSuccessful) {
            BlocProvider.of<BooksBloc>(context).add(const ReloadBooksEvent());
            BlocProvider.of<CustomerCartBloc>(context).add(RestoreCustomerCart(
                customer:
                    BlocProvider.of<AuthenticationBloc>(context).getCustomer));
          }
        },
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state is BooksLoadingSuccessful) {
              return ListView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                itemCount: state.books.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookCard(book: state.books[index]);
                },
              );
            } else if (state is BooksLoading) {
              if (state.isFirstFetch) {
                return const Center(
                  child: SpinKitSpinningLines(color: Palette.lightGreenSalad),
                );
              } else {
                return ListView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.oldBooks.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index < state.oldBooks.length
                        ? BookCard(book: state.oldBooks[index])
                        : const LoadMoreWidget();
                  },
                );
              }
            } else if (state is BooksLoadingFailed) {
              return Center(
                child: Text('Loading failed!\n${state.errorMessage}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  /// Load more books on everscrolling
  void _scrollListener() {
    if (_controller.position.pixels >
        _controller.position.maxScrollExtent + 150) {
      BlocProvider.of<BooksBloc>(context).add(const LoadBooksEvent());
    }
  }
}
