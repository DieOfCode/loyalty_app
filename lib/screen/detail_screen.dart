import 'package:flutter/material.dart';
import 'package:loaylity_app/model/loyalty_program.dart';

class DetailLoyaltyScreen extends StatefulWidget {
  const DetailLoyaltyScreen({Key key, @required this.loyaltyName})
      : super(key: key);
  final String loyaltyName;

  @override
  _DetailLoyaltyScreenState createState() => _DetailLoyaltyScreenState();
}

class _DetailLoyaltyScreenState extends State<DetailLoyaltyScreen> {
  String get loyalty => widget.loyaltyName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Описание программы лояльности'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'О ПЛ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    loyalty,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(loyalty),
          ],
        ),
      ),
    );
  }
}
