import 'package:flutter/material.dart';

class BookImagePage extends StatelessWidget {
  const BookImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Hero(
              tag: 'bookImage',
              transitionOnUserGestures: true,
              child: Image.asset('assets/img/book_placeholder.png'),
            ),
            const Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text('book_placeholder.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
