import 'package:flutter/material.dart';

class BankName extends StatelessWidget {
  final TextStyle? bankNameTextStyle;
  final String bankName;
  final String? bankLogo;

  const BankName(
      {Key? key, this.bankNameTextStyle, required this.bankName, this.bankLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth * (6 / 11) + 10;

    TextStyle defaultBankNameTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: cardWidth * 0.05);

    return Row(
      children: [
        Text(
          bankName,
          style: bankNameTextStyle?.merge(defaultBankNameTextStyle) ??
              defaultBankNameTextStyle,
        ),
        Visibility(
          visible: bankLogo != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(
              bankLogo ?? "lib/assets/image_not_found.png",
              width: cardWidth * 0.09,
              height: cardWidth * 0.09,
            ),
          ),
        ),
      ],
    );
  }
}
