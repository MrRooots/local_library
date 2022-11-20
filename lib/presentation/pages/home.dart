import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';

import 'package:local_library/presentation/pages/profile/profile.dart';
import 'package:local_library/presentation/pages/books_list/books.dart';
import 'package:local_library/presentation/pages/requests/requests.dart';

import 'package:local_library/presentation/widgets/bottom_navigation_bar.dart';

/// Application [HomePage]
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: _buildPage(context, state),
          );
        },
      ),
    );
  }

  Widget _buildPage(final BuildContext context, final NavigationState state) {
    print('[HomePage]: state is $state');
    switch (state.currentIndex) {
      case 0:
        return const RequestsPage();
      case 1:
        return const BooksPage();
      case 2:
        return ProfilePage(
          customer: BlocProvider.of<AuthenticationBloc>(context).getCustomer,
        );
      default:
        return Container();
    }
  }
}
