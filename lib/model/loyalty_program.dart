import 'package:equatable/equatable.dart';

class LoyaltyProgram extends Equatable {
  final String name;
  final String description;

  LoyaltyProgram({this.name, this.description});

  @override
  List<Object> get props => [name, description];
}
