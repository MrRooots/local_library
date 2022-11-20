import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_library/core/themes/palette.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitSpinningLines(color: Palette.lightGreenSalad),
          Text('Loading more books', style: TextStyle(color: Palette.grey))
        ],
      ),
    );
  }
}
