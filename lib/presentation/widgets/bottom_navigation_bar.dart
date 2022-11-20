import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0),
              topLeft: Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (final int currentIndex) {
                BlocProvider.of<NavigationBloc>(context).add(
                  NavigationChanged(currentIndex: currentIndex),
                );
              },
              unselectedItemColor: Palette.black,
              selectedFontSize: 12,
              selectedItemColor: Palette.lightGreenSalad,
              items: const [
                BottomNavigationBarItem(
                  label: 'Requests',
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                BottomNavigationBarItem(
                  label: 'Books',
                  icon: Icon(Icons.menu_book_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Account',
                  icon: Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
