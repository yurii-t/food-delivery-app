import 'package:flutter/material.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class DashSeparator extends StatelessWidget {
  const DashSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (dashWidth * 2)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.darkBlue),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
