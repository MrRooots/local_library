part of 'update_book_bloc.dart';

abstract class UpdateBookEvent extends Equatable {
  const UpdateBookEvent();

  @override
  List<Object> get props => [];
}

class UpdateBook extends UpdateBookEvent {
  final BookEntity newBook;

  const UpdateBook({required this.newBook});
}
