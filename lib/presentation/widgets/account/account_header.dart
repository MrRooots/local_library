import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/presentation/bloc/image_bloc/image_bloc.dart';

class AccountHeader extends StatelessWidget {
  final CustomerEntity customer;

  const AccountHeader({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top * 1.5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => BlocProvider.of<ImageBloc>(context).add(
              const SelectImageFromGallery(),
            ),
            child: Container(
              height: 185,
              width: 185,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: BlocConsumer<ImageBloc, ImageState>(
                  listener: (context, state) {
                    if (state is ImageLoadingFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          duration: const Duration(seconds: 2),
                          content: AwesomeSnackbarContent(
                            color: Palette.red,
                            title: 'Failed to update image!',
                            message: 'Something went wrong :(',
                            contentType: ContentType.failure,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (
                    final BuildContext context,
                    final ImageState state,
                  ) {
                    print('[AccountHeader]: state is $state');
                    if (state is ImageLoadingSuccessful) {
                      return CircleAvatar(
                        maxRadius: 90,
                        backgroundImage: FileImage(state.image),
                      );
                    } else if (state is ImageLoading) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.lightGreenSalad,
                        ),
                        height: 180,
                        width: 180,
                        child: const Center(
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: SpinKitSpinningLines(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const CircleAvatar(
                        maxRadius: 90,
                        backgroundImage: AssetImage('assets/img/avatar.png'),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Text(
            '${customer.name} ${customer.surname}',
            style: const TextStyle(fontSize: 36, color: Colors.white),
          ),
          Text(
            '@${customer.username}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
