import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loaylity_app/bloc/login_bloc/login_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_event.dart';
import 'package:loaylity_app/bloc/login_bloc/login_state.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_event.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';
import 'package:loaylity_app/model/profile.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _password;
  String _confirmedPassword;
  String _login;
  String _name;
  String _surname;
  String _patronymic;
  int _telephoneNumber;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
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
                        return 'Обязатльное поле';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Введите имя'),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Обязатльное поле';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    decoration: InputDecoration(hintText: 'Введите фамилию'),
                    onChanged: (value) {
                      setState(() {
                        _surname = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Обязатльное поле';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    decoration: InputDecoration(hintText: 'Введите Отчество'),
                    onChanged: (value) {
                      setState(() {
                        _patronymic = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Обязатльное поле';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: 'Введите номер телефона'),
                  onChanged: (value) {
                    setState(() {
                      _telephoneNumber = int.parse(value.trim());
                    });
                    print(value);
                  },
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    RegExp regExp = RegExp(r"^((7|8)+([0-9]){10})$");
                    if (regExp.hasMatch(value)) {
                      return null;
                    }
                    return 'Введите корректный номер';
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Введите пароль'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Обязательное поле';
                    } else if (value.length < 8) {
                      return 'Минимальная длина пароля 8 символов';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Повторите пароль'),
                  onChanged: (value) {
                    setState(() {
                      _confirmedPassword = value;
                    });
                  },
                  validator: (value) {
                    if (_password != _confirmedPassword) {
                      return 'Пароли не совпадают';
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
                      var rng = new Random();
                      String cardNumber = '';
                      for (int i = 0; i < 4; i++) {
                        cardNumber += rng.nextInt(9).toString();
                      }
                      Profile profile = Profile(
                          name: _name,
                          login: _login,
                          surname: _surname,
                          patronymic: _patronymic,
                          birthDate: DateFormat.yMMMd().format(DateTime.now()),
                          loyaltyName: 'Test loyalty',
                          cardNumber: int.parse(cardNumber),
                          telephoneNumber: _telephoneNumber,
                          password: _password);
                      print(profile);
                      BlocProvider.of<LoginBloc>(context)
                          .add(CreateProfileEvent(profile));
                      Navigator.pushReplacementNamed(context, '/main');
                    }
                  },
                  child: Text('Зарегистрироваться'),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
