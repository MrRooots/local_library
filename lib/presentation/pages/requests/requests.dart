import 'package:flutter/material.dart';
import 'package:local_library/presentation/widgets/cart_badge.dart';
import 'package:local_library/presentation/widgets/empty_placeholder.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: const [
          CartBadge(),
          SizedBox(width: 10),
        ],
      ),
      body: const EmptyPlaceholder(
        titleText: 'Requests are empty!',
        subtitleText: "You currently don't have any active requests :(",
      ),
    );
  }
}
