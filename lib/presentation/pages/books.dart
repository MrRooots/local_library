import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/widgets/books/body.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: Palette.lightGreenSalad,
        onRefresh: () async => BlocProvider.of<BooksBloc>(context).add(
          const LoadBooksEvent(),
        ),
        child: Stack(
          children: [
            ListView(),
            const BooksPageBody(),
          ],
        ),
      ),
    );
  }
}
