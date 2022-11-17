import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationPage(currentIndex: 1)) {
    on<NavigationChanged>(_navigationChanged);
  }

  FutureOr<void> _navigationChanged(
    final NavigationChanged event,
    final Emitter<NavigationState> emit,
  ) {
    emit(NavigationPage(currentIndex: event.currentIndex));
  }
}
