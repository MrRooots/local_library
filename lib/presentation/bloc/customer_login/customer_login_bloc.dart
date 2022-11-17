import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/usecases/customer/login_customer_with_cache.dart';
import 'package:local_library/domain/usecases/customer/login_customer_with_data.dart';

part 'customer_login_event.dart';
part 'customer_login_state.dart';

class CustomerLoginBloc extends Bloc<CustomerLoginEvent, CustomerLoginState> {
  final LoginCustomerWithCache loginCustomerWithCache;
  final LoginCustomerWithData loginCustomerWithData;

  CustomerLoginBloc({
    required this.loginCustomerWithData,
    required this.loginCustomerWithCache,
  }) : super(const CustomerLoginUndefined()) {
    on<CustomerLoginStart>(_loginCustomer);
    on<ClearLoginFormFields>(_clearForm);
    on<RestoreCustomerSession>(_restoreCustomer);
  }

  /// Start user login procedure
  Future<void> _loginCustomer(
    final CustomerLoginStart event,
    final Emitter<CustomerLoginState> emit,
  ) async {
    if (event.username.isEmpty || event.password.isEmpty) {
      emit(const CustomerLoginFailed(errorMessage: 'All fields are required!'));
      return;
    }

    emit(CustomerLoginLoading());

    final customerOrFailure = await loginCustomerWithData(
      CustomerLoginDataParams(
        username: event.username,
        password: event.password,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    customerOrFailure.fold(
      (final CustomerEntity customer) => emit(
        CustomerLoginSuccessful(customer: customer),
      ),
      (final Failure failure) => emit(CustomerLoginFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }

  /// Clear login form fields
  Future<void> _clearForm(
    final ClearLoginFormFields event,
    final Emitter<CustomerLoginState> emit,
  ) async {
    emit(const CustomerLoginUndefined());
  }

  /// Restore user session from local storage
  Future<void> _restoreCustomer(
    RestoreCustomerSession event,
    Emitter<CustomerLoginState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    final customerOrFailure = await loginCustomerWithCache();

    customerOrFailure.fold(
      (final CustomerEntity customer) => emit(
        CustomerLoginSuccessful(customer: customer),
      ),
      (final Failure failure) => emit(
        const CustomerLoginFailed(errorMessage: ''),
      ),
    );
  }
}
