import 'package:flutter/material.dart';
import 'package:loaylity_app/model/profile.dart';

import '../constant.dart';

typedef OnEditCallback = Function(Profile profile);

class EditScreen extends StatefulWidget {
  const EditScreen({Key key, this.profile, this.onEdit}) : super(key: key);
  final Profile profile;
  final OnEditCallback onEdit;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Profile get profile => widget.profile;
  String _name;
  String _surname;
  String _patronymic;
  String _birthDate;
  int _telephoneNumber;

  @override
  void initState() {
    super.initState();
    setState(() {
      _name = profile.name;
      _surname = profile.surname;
      _patronymic = profile.patronymic;
      _birthDate = profile.birthDate;
      _telephoneNumber = profile.telephoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать профиль'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
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
                initialValue: _name,
              ),
              TextFormField(
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
                },
                initialValue: _surname,
              ),
              TextFormField(
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
                },
                initialValue: _patronymic,
              ),
              Row(
                children: [
                  Text('Сменить дату рождения'),
                  GestureDetector(
                    child: new Icon(Icons.calendar_today),
                    onTap: () async {
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: timeFormatter.parse(_birthDate),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null && datePick != birthDate) {
                        setState(
                          () {
                            _birthDate =
                                timeFormatter.format(datePick); // 08/14/2019
                          },
                        );
                      }
                    },
                  )
                ],
              ),
              TextFormField(
                onChanged: (value) {
                  _telephoneNumber = int.parse(value);
                },
                validator: (value) {
                  RegExp regExp = RegExp(r"^((7|8)+([0-9]){10})$");
                  if (regExp.hasMatch(value)) {
                    return null;
                  }
                  return 'Введите корректный номер';
                },
                initialValue: _telephoneNumber.toString(),
                keyboardType: TextInputType.phone,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Profile updateProfile = profile.copyWith(
                            name: _name,
                            surname: _surname,
                            patronymic: _patronymic,
                            birthDate: _birthDate,
                            telephoneNumber: _telephoneNumber);
                        widget.onEdit(updateProfile);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Изменить')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
