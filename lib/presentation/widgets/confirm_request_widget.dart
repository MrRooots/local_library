import 'package:flutter/material.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/widgets/default_button.dart';

class ConfirmRequestWidget extends StatelessWidget {
  final int count;

  const ConfirmRequestWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: Palette.lightGreenSalad.withOpacity(0.3),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Books:', style: TextStyle(color: Palette.grey)),
                    Text('$count'),
                  ],
                ),
                DefaultButton(
                  onPressed: () {},
                  buttonColor: Palette.lightGreenSalad,
                  text: 'Place request',
                  width: MediaQuery.of(context).size.width * .5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
