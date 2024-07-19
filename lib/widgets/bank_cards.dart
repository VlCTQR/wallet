import 'package:flutter/material.dart';
import 'package:wallet/widgets/credit_cart.dart';

final Map<String, String> bankIBan = {
  "Rabobank": "RABO",
  "ABN AMRO": "ABNA",
  "ING": "INGB",
};

final List<String> banksWithPAN = ["ABN AMRO"];

final Map<String, BankCard> bankCards = {
  "Rabobank": BankCard(
    bankName: "Rabobank",
    bankWebsite: "rabobank.nl",
    // iBan: "NL83 RABO 0332 7232 08",
    // cardHolder: "V.H. Zwaga",
    // cardNumber: "8887",
    // expiryDate: "08/2027",
    iBan: "",
    cardHolder: "",
    cardNumber: "",
    expiryDate: "",
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
  "ABN AMRO": BankCard(
    bankName: "ABN AMRO",
    bankWebsite: "abnamro.nl",
    // iBan: "NL02 ABNA 0123 4567 89",
    // cardHolder: "V.H. Zwaga",
    // cardNumber: "1234",
    // expiryDate: "04/2029",
    // cardPAN: "6734 0056 4826 5020 662",
    iBan: "",
    cardHolder: "",
    cardNumber: "",
    expiryDate: "",
    cardPAN: "",
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
  "ING": BankCard(
    bankName: "ING",
    bankWebsite: "ing.nl",
    // iBan: "NL38 INGB 9876 5432 10",
    // cardHolder: "V.H. Zwaga",
    // cardNumber: "4321",
    // expiryDate: "09/2030",
    iBan: "",
    cardHolder: "",
    cardNumber: "",
    expiryDate: "",
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
};
