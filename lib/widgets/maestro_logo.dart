import 'package:flutter/material.dart';

class MaestroLogo extends StatelessWidget {
  const MaestroLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth * (6 / 11) + 10;

    return Image.asset(
      "lib/assets/Maestro-logo.png",
      width: cardWidth * 0.3,
      height: cardWidth * 0.3,
    );
  }
}
