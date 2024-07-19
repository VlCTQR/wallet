import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Balance extends StatefulWidget {
  final double amount;
  Balance({Key? key, required this.amount}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  late String currency;

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currencyFromPrefs = prefs.getString('currency');
    setState(() {
      currency = currencyFromPrefs ?? "\$";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.13;

    String amountString = widget.amount.toStringAsFixed(2);
    List<String> amountParts = amountString.split('.');
    int whole = int.parse(amountParts[0]);
    int cents = int.parse(amountParts[1]);

    String wholeString = whole.toString();

    bool showCents = true;

    if (whole >= 1000) {
      showCents = false;

      if (whole >= 10000) {
        wholeString = "${(whole.toDouble() / 1000).toString()}k";
      }

      if (whole >= 1000000) {
        wholeString = "${(whole.toDouble() / 1000000).toStringAsFixed(2)}m";
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$currency$wholeString",
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold),
        ),
        if (showCents) SizedBox(width: screenWidth * 0.01),
        Visibility(
          visible: showCents,
          child: Column(
            children: [
              Text(
                cents.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize / 2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: fontSize / 2),
            ],
          ),
        )
      ],
    );
  }
}
