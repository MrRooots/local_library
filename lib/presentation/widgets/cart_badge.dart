import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/pages/cart/cart.dart';

import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';

/// Customer cart animated badge widget
class CartBadge extends StatelessWidget {
  final bool addListener;

  const CartBadge({super.key, this.addListener = false});

  @override
  BlocConsumer build(BuildContext context) {
    return BlocConsumer<CustomerCartBloc, CustomerCartState>(
      listener: (context, state) {
        if (addListener && state is CustomerCartNoBooksRemains) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              duration: const Duration(seconds: 2),
              width: MediaQuery.of(context).size.width,
              content: AwesomeSnackbarContent(
                title: 'Out of stock!',
                message:
                    'Sorry, but the requested book is currently unavailable',
                contentType: ContentType.warning,
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
    );
  }
}
