import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/domain/usecases/customer/register_customer.dart';

part 'customer_register_event.dart';
part 'customer_register_state.dart';

class CustomerRegisterBloc
    extends Bloc<CustomerRegisterEvent, CustomerRegisterState> {
  final RegisterCustomer registerCustomer;

  CustomerRegisterBloc({required this.registerCustomer})
      : super(const CustomerRegisterUndefined()) {
    on<CustomerRegisterStart>(_registerCustomer);
    on<ClearRegisterFormFields>(_clearForm);
  }

  Future<void> _registerCustomer(
    final CustomerRegisterStart event,
    final Emitter<CustomerRegisterState> emit,
  ) async {
    if (event.params.contains('')) {
      emit(const CustomerRegisterFailed(
        errorMessage: 'All fields are required!',
      ));
      return;
    }
    emit(const CustomerRegisterLoading());

    final registerStatus = await registerCustomer(RegisterCustomerParams(
      username: event.username,
      password: event.password,
      name: event.name,
      surname: event.surname,
      address: event.address,
      phone: event.phone,
    ));

    registerStatus.fold(
      (final void status) => emit(const CustomerRegisterSuccessful()),
      (final Failure failure) => emit(CustomerRegisterFailed(
        errorMessage: Utils.mapFailureToString(failure: failure),
      )),
    );
  }

  Future<void> _clearForm(
    final ClearRegisterFormFields event,
    final Emitter<CustomerRegisterState> emit,
  ) async =>
      emit(const CustomerRegisterUndefined());
}
