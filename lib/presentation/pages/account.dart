import 'package:flutter/material.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/domain/entities/customer_entity.dart';

import 'package:local_library/presentation/widgets/account/account_body.dart';
import 'package:local_library/presentation/widgets/account/account_header.dart';

class AccountPage extends StatelessWidget {
  final CustomerEntity customer;

  const AccountPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGreenSalad,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              AccountHeader(customer: customer),
              AccountBody(customer: customer),
            ],
          ),
        ],
      ),
    );
  }
}
