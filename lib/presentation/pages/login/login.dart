import 'package:flutter/material.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/pages/login/components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          const Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/img/main_top.png',
              width: MediaQuery.of(context).size.width * .4,
              color: Palette.lightGreenSalad,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/img/login_bottom.png',
              width: MediaQuery.of(context).size.width * .5,
              color: Palette.lightGreenSalad.withOpacity(.25),
            ),
          ),
        ],
      ),
    );
  }
}
