import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/constants/types.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/usecases/customer/logout_customer.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LogoutCustomer logoutCustomer;

  AuthenticationBloc({required this.logoutCustomer})
      : super(const AuthenticationUnknown()) {
    on<AuthenticationLoggedIn>(_loginCustomer);
    on<AuthenticationLoggedOut>(_logoutCustomer);
  }

  /// Get [CustomerEntity] from [AuthenticationAuth] state
  ///
  /// Returns [CustomerEntity] or [null]
  CustomerEntity get getCustomer => (state as AuthenticationAuth).customer;

  /// Check if [CustomerEntity] is Admin { [CustomerStatus.admin] }
  bool get isAdmin => getCustomer.status == CustomerStatus.admin;

  /// Check if [CustomerEntity] is Moderator { [CustomerStatus.moderator] }
  bool get isModerator => getCustomer.status == CustomerStatus.moderator;

  /// Check if [CustomerEntity] is User { [CustomerStatus.user] }
  bool get isUser => getCustomer.status == CustomerStatus.user;

  /// Logout customer
  Future<void> _logoutCustomer(
    final AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await logoutCustomer();

    emit(const AuthenticationUnauth());
  }

  /// Logout customer and clear cached data
  FutureOr<void> _loginCustomer(
    final AuthenticationLoggedIn event,
    final Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationAuth(customer: event.customer));
  }
}
