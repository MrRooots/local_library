import 'package:flutter/material.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/domain/entities/customer_entity.dart';

import 'package:local_library/presentation/pages/profile/components/profile_body.dart';
import 'package:local_library/presentation/pages/profile/components/profile_header.dart';

class ProfilePage extends StatelessWidget {
  final CustomerEntity customer;

  const ProfilePage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGreenSalad,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              ProfileHeader(customer: customer),
              ProfileBody(customer: customer),
            ],
          ),
        ],
      ),
    );
  }
}
