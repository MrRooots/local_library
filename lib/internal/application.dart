import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/internal/body.dart';

import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/bloc/customer_login/customer_login_bloc.dart';
import 'package:local_library/presentation/bloc/customer_register/customer_register_bloc.dart';
import 'package:local_library/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:local_library/presentation/bloc/update_book_bloc/update_book_bloc.dart';

import 'package:local_library/service_locator.dart';

class LibraryApp extends StatelessWidget {
  const LibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<CustomerLoginBloc>()..add(const RestoreCustomerSession()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
        BlocProvider<CustomerRegisterBloc>(
          create: (context) => sl<CustomerRegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<NavigationBloc>(),
        ),
        BlocProvider<ImageBloc>(
          create: (context) => sl<ImageBloc>(),
        ),
        BlocProvider<BooksBloc>(
          create: (context) => sl<BooksBloc>(),
        ),
        BlocProvider<CustomerCartBloc>(
          create: (context) => sl<CustomerCartBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateBookBloc>(),
        )
      ],
      child: const ApplicationBody(),
    );
  }
}
