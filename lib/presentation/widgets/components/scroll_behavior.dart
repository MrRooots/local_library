import 'package:flutter/material.dart';

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    final BuildContext context,
    final Widget child,
    final ScrollableDetails details,
  ) {
    return child;
  }
}
