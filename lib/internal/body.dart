import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/core/themes/theme.dart';

import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/bloc/customer_login/customer_login_bloc.dart';
import 'package:local_library/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';

import 'package:local_library/presentation/pages/home.dart';
import 'package:local_library/presentation/pages/login/login.dart';
import 'package:local_library/presentation/pages/splash.dart';

import 'package:local_library/presentation/widgets/scroll_behavior.dart';

class ApplicationBody extends StatelessWidget {
  const ApplicationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.myTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: child!,
      ),
      home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuth) {
            // Reset form
            BlocProvider.of<CustomerLoginBloc>(context)
                .add(const ClearLoginFormFields());

            // Set initial screen
            BlocProvider.of<NavigationBloc>(context)
                .add(const NavigationChanged(currentIndex: 1));

            // Load customer profile image
            BlocProvider.of<ImageBloc>(context).add(const LoadExistingImage());

            // Load books
            BlocProvider.of<BooksBloc>(context).add(const LoadBooksEvent());

            // Load customer cart
            BlocProvider.of<CustomerCartBloc>(context)
                .add(RestoreCustomerCart(customer: state.customer));
          } else if (state is AuthenticationLoggedOut) {
            // Reset form
            BlocProvider.of<CustomerLoginBloc>(context).close();

            // Set initial screen
            BlocProvider.of<NavigationBloc>(context).close();

            // Load customer profile image
            BlocProvider.of<ImageBloc>(context).close();

            // Load books
            BlocProvider.of<BooksBloc>(context).close();

            // Load customer cart
            BlocProvider.of<CustomerCartBloc>(context).close();
          }
        },
        builder: (context, state) => AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.25),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          switchOutCurve: const Threshold(0),
          duration: const Duration(milliseconds: 250),
          child: _builPage(state),
        ),
      ),
    );
  }

  Widget _builPage(final AuthenticationState state) {
    if (state is AuthenticationUnknown) {
      print('[Application]: state is $state');
      return const SplashPage(key: ValueKey<String>('splash'));
    } else if (state is AuthenticationAuth) {
      print('[Application]: state is AuthenticationAuth');
      return const HomePage(key: ValueKey<String>('home'));
    } else if (state is AuthenticationUnauth) {
      print('[Application]: state is AuthenticationUnauth');
      return const LoginPage(key: ValueKey<String>('login'));
    } else {
      return const LoginPage(key: ValueKey<String>('login'));
    }
  }
}
