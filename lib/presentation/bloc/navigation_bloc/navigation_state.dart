part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class NavigationPage extends NavigationState {
  const NavigationPage({required super.currentIndex});
}
