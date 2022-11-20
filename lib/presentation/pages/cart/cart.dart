import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/pages/cart/components/cart_books_list.dart';
import 'package:local_library/presentation/widgets/confirm_request_widget.dart';
import 'package:local_library/presentation/widgets/loading_indicator.dart';

import '../../widgets/empty_placeholder.dart';

class CustomerCartPage extends StatelessWidget {
  const CustomerCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
      body: BlocBuilder<CustomerCartBloc, CustomerCartState>(
        builder: (context, state) {
          if (state is CustomerCartLoading) {
            return const LoadingIndicator(includeLogo: false);
          } else {
            if (BlocProvider.of<CustomerCartBloc>(context).booksCount > 0) {
              return const CartBooksList();
            } else {
              return const EmptyPlaceholder(
                titleText: 'Cart is empty!',
                subtitleText: 'You can add books on previous screen!',
              );
            }
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CustomerCartBloc, CustomerCartState>(
        builder: (context, state) {
          final int booksCount =
              BlocProvider.of<CustomerCartBloc>(context).booksCount;

          if (booksCount > 0) {
            return ConfirmRequestWidget(count: booksCount);
          } else {
            return Container(height: 0);
          }
        },
      ),
    );
  }
}
