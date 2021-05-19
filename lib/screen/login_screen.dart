import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_event.dart';
import 'package:loaylity_app/bloc/login_bloc/login_state.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_event.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';
import 'package:loaylity_app/screen/signup_screen.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _login;
  String _password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if (state is ProfileLoginSuccess) {
          Navigator.pushReplacementNamed(context, '/main',
              arguments: state.profile);
        }
        if (state is ProfileLoginFailure) {
          final snackBar = SnackBar(content: Text('Некоректные данные'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loyalty.HD'),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Введите логин'),
                  onChanged: (value) {
                    setState(() {
                      _login = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Не может быть пустым';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Введите пароль'),
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Не может быть пустым';
                    }
                    if (value.length < 8) {
                      return 'Слишком коротки пароль';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(_login);
                      print(_password);
                      BlocProvider.of<LoginBloc>(context).add(
                          AuthenticationLoginRequested(
                              login: _login, password: _password));
                    }
                  },
                  child: Text('Войти'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                  child: Text('Зарегистрироваться'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
