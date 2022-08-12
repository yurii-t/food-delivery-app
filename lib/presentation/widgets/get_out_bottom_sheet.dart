import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class GetoutBottomSheet extends StatelessWidget {
  final VoidCallback callback;
  const GetoutBottomSheet({required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' Are you sure you want to get out?\nAll entered information will be lost',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          ElevatedButton(
            onPressed: () {
              context.router.pop();
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide.none,
              elevation: 0,
              primary: AppColors.orange,
              fixedSize: Size(
                MediaQuery.of(context).size.width,
                52,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide.none,
              ),
            ),
            child: const Text(
              'Stay here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: callback,
            child: const Text(
              'Get out',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
