import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/domain/entities/customer_entity.dart';

import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/widgets/default_button.dart';

class ProfileBody extends StatelessWidget {
  final CustomerEntity customer;

  const ProfileBody({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35.0),
            topLeft: Radius.circular(35.0),
          ),
        ),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                const Text('Status', style: TextStyle(fontSize: 24)),
                Text(customer.status.name),
                const SizedBox(height: 40),
                const Text('Phone number', style: TextStyle(fontSize: 24)),
                Text(customer.phone),
                const SizedBox(height: 40),
                const Text('Address', style: TextStyle(fontSize: 24)),
                Text(customer.address),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButton(
                  text: 'Log Out',
                  buttonColor: Palette.lightGreenSalad,
                  width: MediaQuery.of(context).size.width * .5,
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(const AuthenticationLoggedOut()),
                  // child: const Text('Log out'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
