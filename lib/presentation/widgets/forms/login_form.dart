import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_library/core/themes/palette.dart';

import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/customer_login/customer_login_bloc.dart';

import 'package:local_library/presentation/pages/register.dart';

import 'package:local_library/presentation/widgets/components/default_button.dart';

class LoginForm extends StatefulWidget {
  // final void Function() swapForm;

  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _focusNodeUsername = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  bool _isPasswordHide = true;

  String get username => _usernameController.text.trim();

  String get password => _passwordController.text.trim();

  @override
  void initState() {
    super.initState();

    _focusNodeUsername.addListener(() {
      if (_focusNodeUsername.hasFocus) {
        BlocProvider.of<CustomerLoginBloc>(context)
            .add(const ClearLoginFormFields());
      }
    });

    _focusNodePassword.addListener(() {
      if (_focusNodePassword.hasFocus) {
        BlocProvider.of<CustomerLoginBloc>(context)
            .add(const ClearLoginFormFields());
      }
    });
  }

  @override
  void didChangeDependencies() {
    // BlocProvider.of<CustomerLoginBloc>(context)
    //     .add(const ClearLoginFormFields());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _focusNodeUsername.dispose();
    _focusNodePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: Column(
            children: <Widget>[
              _buildHeader(context, height),
              ..._buildButtons(context, height),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildHeader(final BuildContext context, final double height) {
    return Column(
      children: [
        SizedBox(height: height * .08),
        Text('Sign In', style: Theme.of(context).textTheme.headline1),
        SizedBox(height: height * .01),
        const Text(
          'Sign In into your Local Library account\n using username and password',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * .1),
        _buildUsernameInput(),
        const SizedBox(height: 30.0),
        _buildPasswordField(),
        SizedBox(height: height * .05),
      ],
    );
  }

  List<Widget> _buildButtons(final BuildContext context, final double height) {
    return [
      BlocBuilder<CustomerLoginBloc, CustomerLoginState>(
        builder: (
          final BuildContext context,
          final CustomerLoginState state,
        ) {
          print('[LoginPage]: state $state');
          String? error;
          String? buttonText = 'Sign In';
          double buttonWidth = MediaQuery.of(context).size.width * .8;
          Color buttonColor = Palette.lightGreen;

          if (state is CustomerLoginFailed) {
            error = state.errorMessage;
          } else if (state is CustomerLoginLoading) {
            buttonText = null;
            buttonWidth = 70.0;
          } else if (state is CustomerLoginSuccessful) {
            buttonText = 'Successful';
            buttonColor = Palette.lightGreenSalad;

            Future.delayed(const Duration(seconds: 2)).then((_) {
              BlocProvider.of<CustomerLoginBloc>(context)
                  .add(const ClearLoginFormFields());

              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedIn(customer: state.customer));
            });
          }

          return Expanded(
            child: Column(
              children: [
                Text(
                  error ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Palette.orange),
                ),
                const Spacer(),
                DefaultButton(
                  text: buttonText,
                  width: buttonWidth,
                  buttonColor: buttonColor,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<CustomerLoginBloc>(context).add(
                      CustomerLoginStart(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      TextButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          BlocProvider.of<CustomerLoginBloc>(context)
              .add(const ClearLoginFormFields());
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const RegisterPage(),
          ));
        },
        child: RichText(
          text: const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: Palette.black),
            children: [
              TextSpan(
                text: 'Create it now!',
                style: TextStyle(
                  color: Palette.lightGreenSalad,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      // const Spacer(),
      const Spacer(),
    ];
  }

  /// Build [TextFormField] for password
  TextFormField _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _focusNodePassword,
      enableSuggestions: false,
      keyboardType: TextInputType.emailAddress,
      obscureText: _isPasswordHide,
      autocorrect: false,
      style: const TextStyle(decoration: TextDecoration.none),
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter password...',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _isPasswordHide = !_isPasswordHide),
          child: _isPasswordHide
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
    );
  }

  /// Build [TextFormField] for username
  TextFormField _buildUsernameInput() {
    return TextFormField(
      controller: _usernameController,
      focusNode: _focusNodeUsername,
      style: const TextStyle(decoration: TextDecoration.none),
      decoration: const InputDecoration(
        labelText: 'Username',
        hintText: 'Enter username...',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_circle_rounded),
      ),
    );
  }
}
