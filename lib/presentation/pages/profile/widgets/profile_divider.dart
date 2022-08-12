import 'package:flutter/material.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: AppColors.grey,
    );
  }
}
