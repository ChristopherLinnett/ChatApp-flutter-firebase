import 'package:flutter/material.dart';

enum AuthMode { signUp, login }

class LoginCard extends StatefulWidget {
  const LoginCard({super.key, required this.authCallback});
  final void Function({
    required Map userDetails,
    required AuthMode authMode,
  }) authCallback;

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
    }
    widget.authCallback(userDetails: userDetails, authMode: authMode);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Card(
          elevation: 60,
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: AnimatedContainer(
            padding: EdgeInsets.all(16),
            height: authMode == AuthMode.login ? 301 : 420,
            duration: Duration(milliseconds: 300),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        key: ValueKey('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email Address"),
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
                          key: ValueKey('username'),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Name"),
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
                        key: ValueKey('password1'),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaved: ((newValue) {
                          userDetails['password'] = newValue ?? '';
                        }),
                        decoration: InputDecoration(
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
                          key: ValueKey('password2'),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onSaved: ((newValue) {
                            userDetails['password'] = newValue ?? '';
                          }),
                          decoration: InputDecoration(
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
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            authMode == AuthMode.login ? _trySubmit : null,
                        child: Text(
                            authMode == AuthMode.login ? 'Login' : 'Register'),
                      ),
                      TextButton(
                          child: Text(authMode == AuthMode.login
                              ? 'Create Account'
                              : 'Swith to Log in'),
                          onPressed: () {
                            setState(() {
                              authMode == AuthMode.login
                                  ? authMode = AuthMode.signUp
                                  : authMode = AuthMode.login;
                            });
                          }),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
