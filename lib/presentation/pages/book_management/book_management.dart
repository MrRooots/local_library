import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/presentation/bloc/update_book_bloc/update_book_bloc.dart';
import 'package:local_library/presentation/widgets/default_button.dart';

class BookManagementPage extends StatefulWidget {
  final BookEntity book;

  const BookManagementPage({super.key, required this.book});

  @override
  State<BookManagementPage> createState() => _BookManagementPageState();
}

class _BookManagementPageState extends State<BookManagementPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();

  final FocusNode _titlefocusNode = FocusNode();
  final FocusNode _authorFocusNode = FocusNode();
  final FocusNode _publisherFocusNode = FocusNode();

  String get title => _titleController.text.trim();
  String get author => _authorController.text.trim();
  String get publisher => _publisherController.text.trim();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Editor'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            splashRadius: 0.1,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 16.0,
            ),
          ),
          actions: const [
            // CartBadge(),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            'Edit Book',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Text(
                            'Here you can edit selected book\nusing the form below',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        children: [
                          _buildInput(
                            controller: _titleController,
                            focusNode: _titlefocusNode,
                            labelText: 'Title',
                            textContent: widget.book.title,
                          ),
                          _buildInput(
                            controller: _authorController,
                            focusNode: _authorFocusNode,
                            labelText: 'Author',
                            textContent: widget.book.author,
                          ),
                          _buildInput(
                            controller: _publisherController,
                            focusNode: _publisherFocusNode,
                            labelText: 'Publisher',
                            textContent: widget.book.publisher,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DefaultButton(
                            onPressed: () {},
                            width: MediaQuery.of(context).size.width * .4,
                            text: 'Delete',
                            buttonColor: Palette.red,
                          ),
                          BlocConsumer<UpdateBookBloc, UpdateBookState>(
                            listener: (context, state) {
                              if (state is UpdateBookSuccessful) {
                                Future.delayed(const Duration(
                                  milliseconds: 250,
                                )).then(
                                  (_) => Navigator.of(context).pop(
                                    (widget.book as BookModel).copyWith(
                                      title: title,
                                      author: author,
                                      publisher: publisher,
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              String? text = 'Update';
                              double width =
                                  MediaQuery.of(context).size.width * .4;

                              if (state is UpdateBookLoading) {
                                text = null;
                                width = 70.0;
                              } else if (state is UpdateBookSuccessful) {
                              } else if (state is UpdateBookFailed) {
                                text = 'Failed';
                              }

                              return DefaultButton(
                                onPressed: _updateBook,
                                width: width,
                                text: text,
                                buttonColor: Palette.lightGreenSalad,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build [TextFormField] for username
  TextFormField _buildInput({
    required final TextEditingController controller,
    required final FocusNode focusNode,
    required final String labelText,
    final Icon? suffixIcon,
    final String textContent = '',
  }) {
    if (textContent.isNotEmpty) {
      controller.text = textContent;
    }
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(decoration: TextDecoration.none),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Enter ${labelText.toLowerCase()}...',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffixIcon,
      ),
    );
  }

  void _updateBook() {
    BlocProvider.of<UpdateBookBloc>(context).add(UpdateBook(
      newBook: (widget.book as BookModel)
          .copyWith(title: title, author: author, publisher: publisher),
    ));
  }
}
