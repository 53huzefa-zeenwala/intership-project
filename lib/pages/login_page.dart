import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
import 'package:main_project/widgets/fields/textfield/normal_textfield.dart';
import 'package:main_project/widgets/fields/textfield/password_textfield.dart';
import 'package:main_project/widgets/login_register_form/sign_form.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              height: 40,
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const LoginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not registered yet?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = '';
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
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
                  }),
              PasswordTextField(
                  labelText: 'Password',
                  validate: (value) {
                    if (value == null) {
                      return 'Please fill the password field';
                    }
                    if (value.length < 8) {
                      return 'Password should be 8 character long atleast';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _password = value;
                    });
                  }),
              PrimaryButton(
                title: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(_password);
                    print(_email);
                  }
                },
                fontSize: 22,
                expand: true,
              )
            ],
          )),
    );
  }
}
