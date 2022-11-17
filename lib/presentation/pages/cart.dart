import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/presentation/bloc/customer_cart_cubit/customer_cart_cubit.dart';
import 'package:local_library/presentation/widgets/books/book_card.dart';

class CustomerCartPage extends StatelessWidget {
  const CustomerCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
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
      ),
      body: BlocBuilder<CustomerCartCubit, CustomerCartState>(
        builder: (context, state) {
          final int booksCount =
              BlocProvider.of<CustomerCartCubit>(context).selectedBooksCount;
          if (booksCount > 0) {
            return ListView.builder(
              itemCount: booksCount,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(
                  book: BlocProvider.of<CustomerCartCubit>(context)
                      .selectedBooks[index],
                );
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/empty.png'),
                  const SizedBox(height: 50),
                  Text(
                    'Your cart is empty!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Text('You can add books on previous screen!'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
