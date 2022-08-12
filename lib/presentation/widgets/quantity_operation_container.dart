import 'package:flutter/material.dart';

class QuantityOperationContainer extends StatelessWidget {
  final Widget icon;
  final double size;
  final bool shadow;
  const QuantityOperationContainer({
    required this.icon,
    required this.size,
    required this.shadow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: shadow //shadow == true
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: icon,
    );
  }
}
