import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_library/core/themes/palette.dart';

class LoadingIndicator extends StatelessWidget {
  final bool includeLogo;
  const LoadingIndicator({
    super.key,
    this.includeLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (includeLogo)
          const Text('Local Library Account', style: TextStyle(fontSize: 24.0)),
        if (includeLogo) const SizedBox(height: 50),
        const SpinKitSpinningLines(color: Palette.lightGreenSalad),
        const SizedBox(height: 20),
        const Text('Loading... Please wait')
      ],
    );
  }
}
