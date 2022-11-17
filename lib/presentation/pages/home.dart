import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:local_library/presentation/pages/account.dart';
import 'package:local_library/presentation/pages/books.dart';
import 'package:local_library/presentation/widgets/components/bottom_navigation_bar.dart';

/// Application [HomePage]
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) => _buildPage(context, state),
      ),
    );
  }

  Widget _buildPage(final BuildContext context, final NavigationState state) {
    print('[HomePage]: state is $state');
    switch (state.currentIndex) {
      case 0:
        return Container();
      case 1:
        return const BooksPage();
      case 2:
        final AuthenticationState state =
            BlocProvider.of<AuthenticationBloc>(context).state;

        return AccountPage(customer: (state as AuthenticationAuth).customer);
      default:
        return Container();
    }
  }
}
