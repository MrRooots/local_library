import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String titleText;
  final String subtitleText;

  const EmptyPlaceholder({
    super.key,
    required this.titleText,
    required this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/empty.png'),
          const SizedBox(height: 50),
          Text(
            titleText,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Text(subtitleText, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
