import 'package:flutter/material.dart';

enum AuthMode { signUp, login }

class LoginCard extends StatefulWidget {
  const LoginCard(
      {super.key, required this.authCallback, required this.showLoader});
  final void Function(
      {required Map userDetails,
      required AuthMode authMode,
      required BuildContext ctx}) authCallback;
  final bool showLoader;

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  AuthMode authMode = AuthMode.login;
  Map<String, String> userDetails = {
    'email': '',
    'username': '',
    'password': ''
  };
  String _pass1 = '';

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      _formKey.currentState?.reset();
      widget.authCallback(
          userDetails: userDetails, authMode: authMode, ctx: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 60,
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: "Email Address"),
                      onSaved: ((newValue) {
                        userDetails['email'] = newValue ?? '';
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Provide An Email Address';
                        }
                        if (!value.contains('@')) {
                          return 'Please Supply a Valid Email Address';
                        }
                        if (value.length < 4) {
                          return 'Please Supply a Longer Email Address';
                        }
                        return null;
                      },
                    ),
                    if (authMode == AuthMode.signUp)
                      TextFormField(
                        key: const ValueKey('username'),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: "Name"),
                        onSaved: ((newValue) {
                          userDetails['username'] = newValue ?? '';
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Provide A Username';
                          }
                          if (value.length < 3) {
                            return 'Please Supply a Longer Name';
                          }
                          return null;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password1'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSaved: ((newValue) {
                        userDetails['password'] = newValue ?? '';
                      }),
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (
                        value,
                      ) {
                        if (value == null || value.isEmpty) {
                          return 'Please Provide A Password';
                        }
                        if (value.length < 7) {
                          return 'Please Supply a Longer Password (min 7 characters)';
                        }
                        _pass1 = value;
                        return null;
                      },
                    ),
                    if (authMode == AuthMode.signUp)
                      TextFormField(
                        key: const ValueKey('password2'),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaved: ((newValue) {
                          userDetails['password'] = newValue ?? '';
                        }),
                        decoration: const InputDecoration(
                          labelText: "password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Provide A Password';
                          }
                          if (value != _pass1) {
                            return 'Passwords Don\'t match';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: widget.showLoader
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor: Theme.of(context).cardColor,
                            )
                          : Text(authMode == AuthMode.login
                              ? 'Login'
                              : 'Register'),
                    ),
                    TextButton(
                        onPressed: widget.showLoader
                            ? () {}
                            : () {
                                setState(() {
                                  authMode == AuthMode.login
                                      ? authMode = AuthMode.signUp
                                      : authMode = AuthMode.login;
                                });
                              },
                        child: Text(authMode == AuthMode.login
                            ? 'Create Account'
                            : 'Swith to Log in')),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
