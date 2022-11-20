import 'package:flutter/material.dart';
import 'package:local_library/core/themes/palette.dart';

class HintCartItem extends StatelessWidget {
  const HintCartItem({super.key});

  @override
  ListTile build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Swipe to left to remove from cart',
        textAlign: TextAlign.center,
        style: TextStyle(color: Palette.grey, fontSize: 12),
      ),
    );
  }
}
