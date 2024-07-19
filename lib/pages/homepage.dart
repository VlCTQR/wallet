import 'package:flutter/material.dart';
import 'package:wallet/pages/add_card.dart';
import 'package:wallet/widgets/balance_widget.dart';
import 'package:wallet/widgets/credit_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/widgets/bank_cards.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BankCard? _bankCard;

  @override
  void initState() {
    super.initState();
    _loadBankCard();
  }

  Future<void> updateHomePage() async {
    setState(() {
      _loadBankCard();
    });
  }

  Future<void> _loadBankCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedBank = prefs.getString('selectedBank');
    String? iBan = prefs.getString('iBan');
    String? cardHolder = prefs.getString('cardHolder');
    String? cardNumber = prefs.getString('cardNumber');
    String? expiryDate = prefs.getString('expiryDate');
    String? cardPAN = prefs.getString('cardPAN');

    if (selectedBank != null) {
      BankCard? templateCard = bankCards[selectedBank];
      _bankCard = templateCard?.copyWith(
        cardHolder: cardHolder,
        iBan: iBan,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardPAN: banksWithPAN.contains(selectedBank) ? cardPAN : null,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingCard = 16;
    double cardWidth = screenWidth - paddingCard;
    double cardHeight = cardWidth * (6 / 11) + 10;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCartPage(
                    title: "Edit Card",
                    updateHomePage: updateHomePage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(paddingCard),
            child: _bankCard != null ? _buildBankCardWidget() : Container(),
          ),
          SizedBox(height: cardHeight * 0.1),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(40, 20),
                  topRight: Radius.elliptical(40, 20),
                ),
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: cardHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      FloatingActionButton(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.1,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Balance(amount: 11250.99),
                      FloatingActionButton(
                        backgroundColor: Colors.green[300],
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.1,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: screenWidth * 0.05),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankCardWidget() {
    return SizedBox(
      width: double.infinity,
      child: _bankCard!,
    );
  }
}
