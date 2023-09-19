import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
import 'package:main_project/widgets/custom_fields/textfield/normal_textfield.dart';
import 'package:main_project/widgets/custom_fields/textfield/password_textfield.dart';
import 'package:main_project/widgets/login_register_form/sign_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SignPage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              child: Text(
                'Create Account',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            // const LoginForm(),
            const RegisterForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already registered?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = '';
    _password = '';
    _confirmPassword = '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NormalTextField(
              labelText: 'Email',
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!EmailValidator.validate(value)) {
                  return 'Email is not valid';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              autoFocus: true,
              onSaved: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            PasswordTextField(
              labelText: 'Password',
              onSaved: (value) {
                _password = value;
              },
              validate: (value) {
                if (value == null || value.length < 8) {
                  return 'Password must be 8 character long atleast.';
                }
                return null;
              },
            ),
            PasswordTextField(
              labelText: 'Confirm Password',
              onSaved: (value) {
                _confirmPassword = value;
              },
              validate: (value) {
                if (value == null || value.length < 8) {
                  return 'Password must be 8 character long atleast.';
                }
                if (value != _password) {
                  return 'Password must match!';
                }
                return null;
              },
            ),
            PrimaryButton(
              title: 'Register',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(_email);
                  print(_password);
                  print(_confirmPassword);
                }
              },
              fontSize: 22,
              expand: true,
            )
          ],
        ),
      ),
    );
  }
}
