import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  final String purchaseDate;
  final String name;
  final double totalAmount;
  final String loyaltyProgram;
  final bool payingByBonus;
  final double amountWithBonus;
  final double balanceOfBonus;

  Purchase(this.name, this.purchaseDate, this.totalAmount, this.loyaltyProgram,
      this.payingByBonus, this.amountWithBonus, this.balanceOfBonus);

  @override
  List<Object> get props => [
        name,
        purchaseDate,
        totalAmount,
        loyaltyProgram,
        payingByBonus,
        amountWithBonus,
        balanceOfBonus
      ];
}
