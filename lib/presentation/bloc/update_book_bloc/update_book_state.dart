part of 'update_book_bloc.dart';

abstract class UpdateBookState extends Equatable {
  const UpdateBookState();

  @override
  List<Object> get props => [];
}

class UpdateBookInitial extends UpdateBookState {
  const UpdateBookInitial();
}

class UpdateBookLoading extends UpdateBookState {
  const UpdateBookLoading();
}

class UpdateBookSuccessful extends UpdateBookState {
  const UpdateBookSuccessful();

  @override
  List<Object> get props => [Random().nextDouble()];
}

class UpdateBookFailed extends UpdateBookState {
  final String errorMessage;

  const UpdateBookFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
