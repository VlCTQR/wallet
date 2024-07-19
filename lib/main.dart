import 'package:flutter/material.dart';
import 'package:wallet/pages/homepage.dart';
import 'package:wallet/widgets/credit_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/pages/add_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool cardFinished = prefs.getBool('cardFinished') ?? false;
  runApp(MyApp(cardFinished: cardFinished));
}

class MyApp extends StatelessWidget {
  final bool cardFinished;
  const MyApp({super.key, required this.cardFinished});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: cardFinished
          ? HomePage(
              title: "Wallet",
              // bankCard: BankCard(
              //   bankName: "Rabobank",
              //   bankWebsite: "rabobank.nl",
              //   iBan: "NL83 RABO 0332 7232 08",
              //   cardHolder: "V.H. Zwaga",
              //   cardNumber: "8887",
              //   expiryDate: "08/2027",
              //   backgroundColor: Colors.grey[200],
              //   bankNameTextStyle: TextStyle(
              //     color: Colors.blue[900],
              //     fontStyle: FontStyle.italic,
              //   ),
              //   textColor: Colors.black,
              //   bankLogo: "lib/assets/Rabobank_logo.svg.png",
              //   backgroundImage: "lib/assets/Rabobank_achtergrond.png",
              //   bankNameRightTop: true,
              //   maestroLeftBottom: true,
              //   showInformationFront: false,
              // ),
            )
          : AddCartPage(
              title: "Add Cart Information",
              updateHomePage: () {},
            ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<BankCard> bankCards = [
      BankCard(
        bankName: "Rabobank",
        bankWebsite: "rabobank.nl",
        iBan: "NL83 RABO 0332 7232 08",
        cardHolder: "V.H. Zwaga",
        cardNumber: "8887",
        expiryDate: "08/2027",
        backgroundColor: Colors.grey[200],
        bankNameTextStyle: TextStyle(
          color: Colors.blue[900],
          fontStyle: FontStyle.italic,
        ),
        textColor: Colors.black,
        bankLogo: "lib/assets/Rabobank_logo.svg.png",
        backgroundImage: "lib/assets/Rabobank_achtergrond.png",
        bankNameRightTop: true,
        maestroLeftBottom: true,
        showInformationFront: false,
      ),
      BankCard(
        bankName: "ABN AMRO",
        bankWebsite: "abnamro.nl",
        iBan: "NL02 ABNA 0123 4567 89",
        cardHolder: "V.H. Zwaga",
        cardNumber: "1234",
        expiryDate: "04/2029",
        cardPAN: "6734 0056 4826 5020 662",
        backgroundColor: const Color.fromARGB(255, 10, 134, 126),
        bankNameTextStyle: const TextStyle(
          color: Colors.white,
        ),
        textColor: Colors.white,
        bankLogo: "lib/assets/abn_logo.png",
        bankLogoRight: false,
        backgroundImage: "lib/assets/abn_achtergrond.png",
        bankNameLeftTop: true,
        maestroRightTop: true,
        showInformationFront: true,
        showInformationBack: false,
      ),
      BankCard(
        bankName: "ING",
        bankWebsite: "ing.nl",
        iBan: "NL38 INGB 9876 5432 10",
        cardHolder: "V.H. Zwaga",
        cardNumber: "4321",
        expiryDate: "09/2030",
        backgroundColor: Colors.orange[700],
        bankNameTextStyle: const TextStyle(
          color: Colors.white,
        ),
        textColor: Colors.white,
        bankLogo: "lib/assets/ing-logo.png",
        backgroundImage: "lib/assets/ing_achtergrond.jpg",
        bankNameLeftTop: true,
        maestroRightTop: true,
        showInformationFront: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bankCards.length,
              itemBuilder: (context, index) {
                return bankCards[index];
              },
            ),
            // Voeg hier andere widgets toe zoals gewenst
          ],
        ),
      ),
    );
  }
}
