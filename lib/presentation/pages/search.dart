import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchConstroller = TextEditingController();
  final FocusNode _searchNode = FocusNode();

  String get searchQuery => _searchConstroller.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchConstroller.dispose();
    _searchNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Books'),
          centerTitle: true,
          elevation: 0.0,
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _searchConstroller,
                focusNode: _searchNode,
                style: const TextStyle(decoration: TextDecoration.none),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
