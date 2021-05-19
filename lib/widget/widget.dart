import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loaylity_app/model/purchase.dart';

class PurchaseTable extends StatefulWidget {
  const PurchaseTable({
    Key key,
  }) : super(key: key);

  @override
  _PurchaseTableState createState() => _PurchaseTableState();
}

class _PurchaseTableState extends State<PurchaseTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          columns: [
            DataColumn(label: Text('Дата покупки')),
            DataColumn(
              label: Text('Магазин'),
            ),
            DataColumn(
              label: Text('Сумма покупки'),
            ),
            DataColumn(
              label: Text('Акция'),
            ),
            DataColumn(
              label: Text('Оплата бонусами'),
            ),
            DataColumn(
              label: Text('Итоговая сумма'),
            ),
            DataColumn(label: Text('Остаток бонусов')),
          ],
          rows: List<DataRow>.generate(
            purchases.length,
            (index) {
              Purchase purchase = purchases[index];
              return DataRow(
                onSelectChanged: (bool) {
                  print('Bool');
                },
                cells: [
                  DataCell(
                    Text(purchase.purchaseDate),
                  ),
                  DataCell(Text(purchase.name)),
                  DataCell(Text(purchases[index].totalAmount.toString())),
                  DataCell(Text(purchases[index].loyaltyProgram)),
                  DataCell(purchases[index].payingByBonus
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.close_outlined,
                          color: Colors.red,
                        )),
                  DataCell(Text(purchases[index].amountWithBonus.toString())),
                  DataCell(Text(purchases[index].balanceOfBonus.toString()))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

List<Purchase> purchases = [
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000),
  Purchase('Тестовый бонус', DateFormat.yMMMd().format(DateTime.now()), 1200,
      'Скидка', true, 1100, 2000)
];
