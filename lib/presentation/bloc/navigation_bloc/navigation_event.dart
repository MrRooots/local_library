part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationChanged extends NavigationEvent {
  final int currentIndex;

  const NavigationChanged({required this.currentIndex});
}
