import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/customer_login/customer_login_bloc.dart';
import 'package:local_library/presentation/widgets/components/background_blob.dart';

/// Application [SplashPage]
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('[SplashPage]: build called');
    return BlocConsumer<CustomerLoginBloc, CustomerLoginState>(
      listener: (context, state) {
        print('[SplashPage]: state is $state');
        if (state is CustomerLoginSuccessful) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(customer: state.customer),
          );
        } else if (state is CustomerLoginFailed) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            const AuthenticationLoggedOut(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                ...BackgroundBlob.getBlobs(
                  screenWidth: MediaQuery.of(context).size.width,
                  blobCount: 3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Local Library Account',
                        style: TextStyle(fontSize: 24.0)),
                    SizedBox(height: 50),
                    SpinKitSpinningLines(color: Palette.lightGreenSalad),
                    SizedBox(height: 20),
                    Text('Loading... Please wait')
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
