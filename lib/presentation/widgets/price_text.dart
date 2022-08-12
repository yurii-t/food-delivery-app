import 'package:flutter/material.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class PriceText extends StatelessWidget {
  final double textSize;
  final num itemPrice;
  const PriceText({required this.textSize, required this.itemPrice, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: '$itemPrice',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontSize: textSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        WidgetSpan(
          child: Transform.translate(
            offset: const Offset(2, -8),
            child: const Text(
              'R',
              textScaleFactor: 0.7,
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
