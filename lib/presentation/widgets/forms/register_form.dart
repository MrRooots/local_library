import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_library/core/themes/palette.dart';
import 'package:local_library/presentation/bloc/customer_register/customer_register_bloc.dart';
import 'package:local_library/presentation/widgets/components/default_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _focusNodeUsername = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _surnameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  bool _isPasswordHide = true;

  String get username => _usernameController.text.trim();
  String get password => _passwordController.text.trim();
  String get name => _nameController.text.trim();
  String get surname => _surnameController.text.trim();
  String get phone => _phoneController.text.trim();
  String get address => _addressController.text.trim();

  @override
  void initState() {
    super.initState();
    final List<FocusNode> focusNodes = [
      _focusNodeUsername,
      _focusNodePassword,
      _nameFocusNode,
      _surnameFocusNode,
      _phoneFocusNode,
      _addressFocusNode,
    ];
    for (final FocusNode node in focusNodes) {
      node.addListener(
        () => node.hasFocus
            ? BlocProvider.of<CustomerRegisterBloc>(context)
                .add(const ClearRegisterFormFields())
            : null,
      );
    }
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<CustomerRegisterBloc>(context)
        .add(const ClearRegisterFormFields());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

    _focusNodeUsername.dispose();
    _focusNodePassword.dispose();
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();

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
        Text('Sign Up', style: Theme.of(context).textTheme.headline1),
        SizedBox(height: height * .01),
        const Text(
          'Create your Local Library account\n by filling the form below',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * .1),
        _buildUsernameInput(),
        const SizedBox(height: 15.0),
        _buildPasswordInput(),
        const SizedBox(height: 15.0),
        _buildInput(
          controller: _nameController,
          focusNode: _nameFocusNode,
          labelText: 'Name',
          suffixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 15.0),
        _buildInput(
          controller: _surnameController,
          focusNode: _surnameFocusNode,
          labelText: 'Surname',
          suffixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 15.0),
        _buildInput(
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          labelText: 'Phone',
          suffixIcon: const Icon(Icons.phone),
        ),
        const SizedBox(height: 15.0),
        _buildInput(
          controller: _addressController,
          focusNode: _addressFocusNode,
          labelText: 'Address',
          suffixIcon: const Icon(Icons.location_on_sharp),
        ),
        SizedBox(height: height * .05),
      ],
    );
  }

  List<Widget> _buildButtons(final BuildContext context, final double height) {
    return [
      BlocBuilder<CustomerRegisterBloc, CustomerRegisterState>(
        builder: (
          final BuildContext context,
          final CustomerRegisterState state,
        ) {
          print('[RegisterPage]: state $state');
          String? error;
          String? buttonText = 'Sign Up';
          double buttonWidth = MediaQuery.of(context).size.width * .8;
          Color buttonColor = Palette.lightGreen;

          if (state is CustomerRegisterFailed) {
            error = state.errorMessage;
          } else if (state is CustomerRegisterLoading) {
            buttonText = null;
            buttonWidth = 70.0;
          } else if (state is CustomerRegisterSuccessful) {
            buttonText = 'Successful';
            buttonColor = Palette.lightGreenSalad;

            Future.delayed(const Duration(seconds: 2)).then((_) {
              BlocProvider.of<CustomerRegisterBloc>(context)
                  .add(const ClearRegisterFormFields());

              Navigator.of(context).pop();
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
                const SizedBox(height: 30.0),
                DefaultButton(
                  text: buttonText,
                  width: buttonWidth,
                  buttonColor: buttonColor,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<CustomerRegisterBloc>(context).add(
                      CustomerRegisterStart(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                        surname: _surnameController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
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
          // FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        },
        child: RichText(
          text: const TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: Palette.black),
            children: [
              TextSpan(
                text: 'Sign In!',
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
  TextFormField _buildPasswordInput() {
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

  /// Build [TextFormField] for username
  TextFormField _buildInput({
    required final TextEditingController controller,
    required final FocusNode focusNode,
    required final String labelText,
    required final Icon suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(decoration: TextDecoration.none),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Enter ${labelText.toLowerCase()}...',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
