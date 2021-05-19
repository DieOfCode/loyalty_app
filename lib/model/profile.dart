import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  static String table = 'habits';
  final int id;
  final String login;
  final String name;
  final String surname;
  final String patronymic;
  final String birthDate;
  final String loyaltyName;
  final int cardNumber;
  final int telephoneNumber;
  final String password;

  Profile(
      {this.id,
      this.login,
      this.password,
      this.name,
      this.surname,
      this.patronymic,
      this.birthDate,
      this.loyaltyName,
      this.cardNumber,
      this.telephoneNumber});

  static Profile fromMap(Map<String, dynamic> map) {
    return Profile(
        id: map['id'],
        login: map['login'],
        password: map['password'],
        name: map['name'],
        surname: map['surname'],
        patronymic: map['patronymic'],
        birthDate: map['birth_date'],
        loyaltyName: map['loyalty_name'],
        cardNumber: map['loyalty_number'],
        telephoneNumber: map['telephone_number']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'login': this.login,
      'name': this.name,
      'surname': this.surname,
      'patronymic': this.patronymic,
      'telephone_number': telephoneNumber,
      'password': this.password,
      'loyalty_number': this.cardNumber,
      'loyalty_name': this.loyaltyName,
      'birth_date': birthDate
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  List<Object> get props => [
        this.id,
        this.login,
        this.password,
        this.name,
        this.surname,
        this.patronymic,
        this.birthDate,
        this.loyaltyName,
        this.cardNumber,
        this.telephoneNumber
      ];

  Profile copyWith(
      {int id,
      String login,
      String password,
      String name,
      String surname,
      String patronymic,
      String birthDate,
      String loyaltyName,
      int cardNumber,
      int telephoneNumber}) {
    return Profile(
        id: this.id,
        login: this.login,
        password: this.password,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        patronymic: patronymic ?? this.patronymic,
        birthDate: birthDate ?? this.birthDate,
        cardNumber: this.cardNumber,
        loyaltyName: this.loyaltyName,
        telephoneNumber: telephoneNumber ?? this.telephoneNumber);
  }
}
