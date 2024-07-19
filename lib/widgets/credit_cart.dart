import 'package:flutter/material.dart';
import 'package:wallet/widgets/flip_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankCard extends StatefulWidget {
  final Color? backgroundColor;
  final String? backgroundImage;
  final Color? textColor;
  final String bankName;
  final TextStyle? bankNameTextStyle;
  final String iBan;
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;
  final String? cardPAN;
  final String bankWebsite;
  final String? bankLogo;
  final bool bankLogoRight;
  final bool? showInformationFront;
  final bool? showInformationBack;
  final bool bankNameLeftTop;
  final bool bankNameRightTop;
  final bool bankNameLeftBottom;
  final bool bankNameRightBottom;
  final bool maestroLeftTop;
  final bool maestroRightTop;
  final bool maestroLeftBottom;
  final bool maestroRightBottom;

  BankCard({
    Key? key,
    this.backgroundColor,
    this.backgroundImage,
    this.textColor,
    required this.bankName,
    this.bankNameTextStyle,
    this.bankLogo,
    this.bankLogoRight = true,
    this.showInformationFront = false,
    this.showInformationBack = true,
    this.bankNameLeftTop = false,
    this.bankNameRightTop = false,
    this.bankNameLeftBottom = false,
    this.bankNameRightBottom = false,
    this.maestroLeftTop = false,
    this.maestroRightTop = false,
    this.maestroLeftBottom = false,
    this.maestroRightBottom = false,
    required this.bankWebsite,
    required this.iBan,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
    this.cardPAN,
  }) : super(key: key) {
    assert(
      !(bankNameLeftTop && maestroLeftTop) ||
          !(bankNameRightTop && maestroRightTop) ||
          !(bankNameLeftBottom && maestroLeftBottom) ||
          !(bankNameRightBottom && maestroRightBottom),
      'bankName and Maestro logo cannot be positioned in the same corner.',
    );
  }

  BankCard copyWith({
    String? iBan,
    String? cardHolder,
    String? cardNumber,
    String? expiryDate,
    String? cardPAN,
  }) {
    return BankCard(
      iBan: iBan ?? this.iBan,
      cardHolder: cardHolder ?? this.cardHolder,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardPAN: cardPAN ?? this.cardPAN,
      bankName: bankName,
      bankWebsite: bankWebsite,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      textColor: textColor,
      bankNameTextStyle: bankNameTextStyle,
      bankLogo: bankLogo,
      bankLogoRight: bankLogoRight,
      showInformationFront: showInformationFront,
      showInformationBack: showInformationBack,
      bankNameLeftTop: bankNameLeftTop,
      bankNameLeftBottom: bankNameLeftBottom,
      bankNameRightBottom: bankNameRightBottom,
      bankNameRightTop: bankNameRightTop,
      maestroLeftTop: maestroLeftTop,
      maestroLeftBottom: maestroLeftBottom,
      maestroRightBottom: maestroRightBottom,
      maestroRightTop: maestroRightTop,
    );
  }

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  bool isFrontVisible = true;
  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth * (6 / 11) + 10;

    TextStyle defaultBankNameTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: cardWidth * 0.05);

    TextStyle informationLabelTextStyle = TextStyle(
        fontSize: cardWidth * 0.025, color: widget.textColor ?? Colors.black);

    TextStyle informationTextStyle =
        TextStyle(fontSize: cardWidth * 0.035, color: Colors.black);

    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: () {
          setState(() {
            controller.flipCard();
          });
        },
        child: FlipCardWidget(
          front: _buildFrontSide(
            cardWidth,
            cardHeight,
            defaultBankNameTextStyle,
            informationLabelTextStyle,
            informationTextStyle,
          ),
          back: _buildBackSide(
            cardWidth,
            cardHeight,
            defaultBankNameTextStyle,
            informationLabelTextStyle,
            informationTextStyle,
          ),
          controller: controller,
        ),
        // child: isFrontVisible
        //     ? _buildFrontSide(cardWidth, cardHeight, defaultBankNameTextStyle,
        //         informationLabelTextStyle, informationTextStyle)
        //     : _buildBackSide(cardWidth, cardHeight, defaultBankNameTextStyle,
        //         informationLabelTextStyle, informationTextStyle),
      ),
    );
  }

  Widget _buildFrontSide(
      double cardWidth,
      double cardHeight,
      TextStyle defaultBankNameTextStyle,
      TextStyle informationLabelTextStyle,
      TextStyle informationTextStyle) {
    return Card(
      elevation: 4.0,
      color: widget.backgroundColor ?? Colors.black54,
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            if (widget.backgroundImage != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      widget.backgroundImage!,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: widget.showInformationFront == true
                  ? cardHeight * 0.05
                  : (widget.bankNameRightTop || widget.bankNameLeftTop)
                      ? cardHeight * 0.05
                      : null,
              left: widget.showInformationFront == true
                  ? cardWidth * 0.05
                  : (widget.bankNameLeftTop || widget.bankNameLeftBottom)
                      ? cardWidth * 0.05
                      : null,
              right: widget.showInformationFront == true
                  ? null
                  : (widget.bankNameRightTop || widget.bankNameRightBottom)
                      ? cardWidth * 0.05
                      : null,
              bottom: widget.showInformationFront == true
                  ? null
                  : (widget.bankNameLeftBottom || widget.bankNameRightBottom)
                      ? cardHeight * 0.0
                      : null,
              child: Row(
                children: [
                  if ((!widget.bankLogoRight) && widget.bankLogo != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(
                        widget.bankLogo!,
                        width: cardWidth * 0.09,
                        height: cardWidth * 0.09,
                      ),
                    ),
                  Text(
                    widget.bankName,
                    style: widget.bankNameTextStyle
                            ?.merge(defaultBankNameTextStyle) ??
                        defaultBankNameTextStyle,
                  ),
                  if ((widget.bankLogoRight) && widget.bankLogo != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        widget.bankLogo!,
                        width: cardWidth * 0.09,
                        height: cardWidth * 0.09,
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              left: cardWidth * 0.1,
              top: cardHeight * 0.2,
              child: FractionalTranslation(
                translation: const Offset(0.0, 0.5),
                child: Image.asset(
                  "lib/assets/chip.png",
                  width: cardWidth * 0.13,
                  height: cardWidth * 0.13,
                ),
              ),
            ),
            Positioned(
              left: widget.showInformationFront == true
                  ? null
                  : (widget.maestroLeftTop || widget.maestroLeftBottom)
                      ? 0.0
                      : null,
              right: widget.showInformationFront == true
                  ? cardHeight * 0.0
                  : (widget.maestroRightTop || widget.maestroRightBottom)
                      ? 0.0
                      : null,
              top: widget.showInformationFront == true
                  ? cardHeight * -0.05
                  : (widget.maestroRightTop || widget.maestroLeftTop)
                      ? cardWidth * -0.05
                      : null,
              bottom: widget.showInformationFront == true
                  ? null
                  : (widget.maestroRightBottom || widget.maestroLeftBottom)
                      ? cardHeight * -0.05
                      : null,
              child: FractionalTranslation(
                translation: const Offset(0.0, 0.0),
                child: Image.asset(
                  widget.textColor == Colors.white
                      ? "lib/assets/Maestro-logo-white.png"
                      : "lib/assets/Maestro-logo.png",
                  width: cardWidth * 0.3,
                  height: cardWidth * 0.3,
                ),
              ),
            ),
            Positioned(
              top: cardHeight * 0.55,
              left: cardWidth * 0.05,
              child: Visibility(
                visible: widget.showInformationFront ?? false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "rekening houder",
                      style: informationLabelTextStyle,
                    ),
                    Text(
                      widget.cardHolder,
                      style: informationTextStyle,
                    ),
                    SizedBox(height: cardHeight * 0.05),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "rekening nr.",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.iBan,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(width: cardWidth * 0.1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "pas nr.",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.cardNumber,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(width: cardWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "geldig t/m",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.expiryDate,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackSide(
      double cardWidth,
      double cardHeight,
      TextStyle defaultBankNameTextStyle,
      TextStyle informationLabelTextStyle,
      TextStyle informationTextStyle) {
    return Card(
      elevation: 4.0,
      color: widget.backgroundColor ?? Colors.black54,
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: cardHeight * 0.05, left: cardWidth * 0.03),
              child: Text(
                "VRAGEN? KIJK IN DE APP OF OP ${widget.bankWebsite.toUpperCase()}",
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: cardHeight * 0.04,
                ),
              ),
            ),
            Positioned(
              top: cardHeight * 0.15,
              child: Image.asset(
                "lib/assets/magnet_strip.jpg",
                height: cardHeight * 0.2,
              ),
            ),
            Visibility(
              visible: !(widget.showInformationBack ?? false),
              child: Positioned(
                top: cardHeight * 0.45,
                left: cardWidth * 0.05,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: cardHeight * 0.06,
                      color: widget.textColor,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Vragen?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: "\nKijk in de app\nof op "),
                      TextSpan(
                          text: widget.bankWebsite,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.cardPAN != null,
              child: Positioned(
                top: cardHeight * 0.75,
                left: cardWidth * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "kaart nr.",
                      style: informationLabelTextStyle,
                    ),
                    Text(
                      widget.cardPAN ?? "",
                      style: informationTextStyle,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: cardHeight * 0.55,
              left: cardWidth * 0.05,
              child: Visibility(
                visible: widget.showInformationBack ?? false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "rekening houder",
                      style: informationLabelTextStyle,
                    ),
                    Text(
                      widget.cardHolder,
                      style: informationTextStyle,
                    ),
                    SizedBox(height: cardHeight * 0.05),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "rekening nr.",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.iBan,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(width: cardWidth * 0.1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "pas nr.",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.cardNumber,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(width: cardWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "geldig t/m",
                              style: informationLabelTextStyle,
                            ),
                            Text(
                              widget.expiryDate,
                              style: informationTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
