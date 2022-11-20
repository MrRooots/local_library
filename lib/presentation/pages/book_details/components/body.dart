import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/presentation/pages/book_details/components/book_image_page.dart';
import 'package:local_library/presentation/widgets/expandable_text.dart';

class BookDetailsPageBody extends StatelessWidget {
  final BookEntity book;

  const BookDetailsPageBody({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Author',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(book.author,
                            style: const TextStyle(fontSize: 14.0)),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Text(
                          book.title,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Publisher',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Text(book.publisher,
                            style: const TextStyle(fontSize: 14.0)),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BookImagePage(),
                        ),
                      ),
                      child: Hero(
                        tag: 'bookImage',
                        transitionOnUserGestures: true,
                        child: Image.asset('assets/img/book_placeholder.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Publish date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                DateFormat.yMMMMd().format(book.publishedAt),
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 15.0),
              const Text(
                'Here will be book description...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const ExpandableTextWidget(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec finibus arcu. Cras ac massa a urna facilisis euismod in id mi. Suspendisse at dui condimentum quam cursus dictum a eu ligula. Morbi aliquet, erat a rutrum eleifend, mi lacus hendrerit lorem, eget aliquet arcu ipsum et neque. Curabitur lobortis rhoncus imperdiet. Nam a mi rutrum ante blandit commodo et eget sem. Proin pulvinar nibh ut lacus imperdiet, a gravida arcu mattis. Nunc placerat neque nec eros rhoncus aliquam. Nunc ultrices vehicula dignissim. Maecenas rhoncus pulvinar nisl a hendrerit. Duis varius est eget elit tincidunt mollis. Sed sit amet odio dapibus, tempus diam id, aliquam magna.\n\n"
                    "Nulla blandit ultricies orci, ac sollicitudin ante aliquam et. Cras vestibulum viverra enim, sed tempus felis sollicitudin ac. Integer vulputate tincidunt nunc vitae vulputate. In tempus eget felis in sollicitudin. Phasellus nisi urna, ullamcorper id convallis id, mattis at mauris. Cras non orci lectus. Integer a laoreet felis. Mauris et pretium ipsum. Suspendisse rutrum porta diam, luctus maximus risus scelerisque in. Aenean luctus nibh in velit lacinia ultrices.",
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
