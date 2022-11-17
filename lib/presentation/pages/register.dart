import 'package:flutter/material.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/widgets/forms/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          const Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RegisterForm(),
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
              'assets/img/signup_top.png',
              width: MediaQuery.of(context).size.width * .4,
              color: Palette.lightGreenSalad,
            ),
          ),
        ],
      ),
    );
  }
}
