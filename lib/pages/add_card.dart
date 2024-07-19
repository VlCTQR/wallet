import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:wallet/pages/homepage.dart';
import 'package:wallet/widgets/add_cart_text_field.dart';
import 'package:wallet/widgets/bank_cards.dart';
import 'package:wallet/widgets/credit_cart.dart';

class AddCartPage extends StatefulWidget {
  final String title;
  final Function updateHomePage;
  AddCartPage({Key? key, required this.title, required this.updateHomePage})
      : super(key: key);

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  late TextEditingController _iBanController;
  late TextEditingController _cardHolderController;
  late TextEditingController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cardPANController;
  String? _selectedBank;

  @override
  void initState() {
    super.initState();
    _iBanController = TextEditingController();
    _cardHolderController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cardPANController = TextEditingController();
    _selectedBank = null;

    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBank = prefs.getString('selectedBank');
      _iBanController.text = prefs.getString('iBan') ?? '';
      _cardHolderController.text = prefs.getString('cardHolder') ?? '';
      _cardNumberController.text = prefs.getString('cardNumber') ?? '';
      _expiryDateController.text = prefs.getString('expiryDate') ?? '';
      _cardPANController.text = prefs.getString('cardPAN') ?? '';
    });
  }

  @override
  void dispose() {
    _iBanController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cardPANController.dispose();
    super.dispose();
  }

  Future<void> _updateCardInfo() async {
    setState(() {});
  }

  Future<void> _saveCardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('iBan', _iBanController.text);
    await prefs.setString('cardHolder', _cardHolderController.text);
    await prefs.setString('cardNumber', _cardNumberController.text);
    await prefs.setString('expiryDate', _expiryDateController.text);
    await prefs.setString('selectedBank', _selectedBank!);
    if (banksWithPAN.contains(_selectedBank)) {
      await prefs.setString('cardPAN', _cardPANController.text);
    }
    debugPrint("Saved Data");
    setState(() {});
  }

  String? _validateInputs() {
    // Controleer of de bank is geselecteerd
    if (_selectedBank == null) {
      return "Selecteer een bank.";
    }
    debugPrint(_iBanController.text.length.toString());
    // Controleer of het IBAN-nummer in het juiste formaat is
    if (!_iBanController.text.startsWith("NL") ||
        _iBanController.text.length != 22) {
      return "Ongeldig rekening nummer.";
    }

    // Controleer of de bankcode overeenkomt met de verwachte bankcode
    String expectedBankCode = bankIBan[_selectedBank!] ?? "";
    String actualBankCode = _iBanController.text.substring(5, 9);
    if (actualBankCode != expectedBankCode) {
      return "Ongeldige bankcode in rekening nummer.";
    }

    // Controleer of de rekeninghouder alleen letters bevat
    if (!RegExp(r'^[a-zA-Z\s.]+$').hasMatch(_cardHolderController.text)) {
      return "Ongeldige naam voor rekeninghouder.";
    }

    // Controleer of het pasnummer alleen cijfers bevat
    if (!RegExp(r'^[0-9]+$').hasMatch(_cardNumberController.text)) {
      return "Ongeldig pasnummer.";
    }

    // Controleer of het kaartnummer alleen cijfers bevat als het nodig is
    if (banksWithPAN.contains(_selectedBank) &&
        !RegExp(r'^[0-9\s]+$').hasMatch(_cardPANController.text)) {
      return "Ongeldig kaartnummer.";
    }

    // Controleer of de vervaldatum in het formaat MM/yyyy is
    if (!RegExp(r'^\d{2}/\d{4}$').hasMatch(_expiryDateController.text)) {
      return "Ongeldige vervaldatum.";
    }

    // Geen fouten gevonden, retourneer null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingCard = 16;
    double cardWidth = screenWidth - paddingCard;
    double cardHeight = cardWidth * (6 / 11) + 10;

    Widget buildCardWidget() {
      if (_selectedBank != null) {
        BankCard? templateCard = bankCards[_selectedBank!];
        BankCard? customCard = templateCard?.copyWith(
          cardHolder: _cardHolderController.text,
          iBan: _iBanController.text,
          cardNumber: _cardNumberController.text,
          expiryDate: _expiryDateController.text,
          cardPAN: banksWithPAN.contains(_selectedBank!)
              ? _cardPANController.text
              : null,
        );
        return Padding(
          padding: EdgeInsets.all(paddingCard),
          child: customCard ?? Container(),
        );
      } else {
        return Padding(
          padding: EdgeInsets.all(paddingCard),
          child: DottedBorder(
            strokeWidth: 2,
            dashPattern: [cardWidth * 0.05, cardWidth * 0.04],
            radius: const Radius.circular(10),
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCardWidget(),
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
              child: Padding(
                padding: EdgeInsets.all(paddingCard),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: cardHeight * 0.1),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Bank",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.purple[800],
                        value: _selectedBank,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBank = newValue;
                            _updateCardInfo();
                          });
                        },
                        items: bankCards.keys.map((String bankName) {
                          return DropdownMenuItem<String>(
                            value: bankName,
                            child: Text(bankName),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldAddCart(
                        textEditingController: _iBanController,
                        onChanged: _updateCardInfo,
                        labelText: 'Rekening nummer',
                        hintText:
                            'NLXX ${bankIBan[_selectedBank]} XXXX XXXX XX',
                      ),
                      TextFieldAddCart(
                        textEditingController: _cardHolderController,
                        textInputType: TextInputType.name,
                        onChanged: _updateCardInfo,
                        labelText: 'Rekening houder',
                        hintText: "V.H. Zwaga",
                      ),
                      TextFieldAddCart(
                        textEditingController: _cardNumberController,
                        textInputType: TextInputType.number,
                        onChanged: _updateCardInfo,
                        labelText: 'Pas nummer',
                        hintText: "XXXX",
                      ),
                      if (banksWithPAN.contains(_selectedBank))
                        TextFieldAddCart(
                          textEditingController: _cardPANController,
                          textInputType: TextInputType.number,
                          onChanged: _updateCardInfo,
                          labelText: 'Kaart nummer',
                          hintText: '1234 5678 9012 3456',
                        ),
                      TextFieldAddCart(
                        textEditingController: _expiryDateController,
                        textInputType: TextInputType.datetime,
                        onChanged: _updateCardInfo,
                        labelText: 'Geldig tot en met',
                        hintText: "MM/yyyy",
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          String? errorMessage = _validateInputs();
                          if (errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                              ),
                            );
                          } else {
                            await _saveCardInfo();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            bool cardFinished =
                                prefs.getBool('cardFinished') ?? false;
                            if (!cardFinished) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                    title: 'Wallet',
                                  ),
                                ),
                              );
                              await prefs.setBool('cardFinished', true);
                            }
                            if (cardFinished) {
                              await widget.updateHomePage();
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
