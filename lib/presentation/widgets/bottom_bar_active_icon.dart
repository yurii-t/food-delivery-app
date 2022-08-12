import 'package:flutter/material.dart';
import 'package:food_delivery_app/theme/app_gradients.dart';

class BottomBarActiveIcon extends StatelessWidget {
  final Widget icon;
  const BottomBarActiveIcon({required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _size = 48;

    return Container(
      padding: const EdgeInsets.all(10),
      height: _size,
      width: _size,
      decoration: BoxDecoration(
        gradient: AppGradients.orangeGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
    );
  }
}
