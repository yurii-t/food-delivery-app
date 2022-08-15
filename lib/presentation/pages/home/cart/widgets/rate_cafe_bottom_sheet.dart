import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class RateCafeBottomSheet extends StatefulWidget {
  final String restaurantId;
  const RateCafeBottomSheet({required this.restaurantId, Key? key})
      : super(key: key);

  @override
  State<RateCafeBottomSheet> createState() => _RateCafeBottomSheetState();
}

class _RateCafeBottomSheetState extends State<RateCafeBottomSheet> {
  double _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Tap a star to rate cafe\non the application',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          RatingBar(
            ratingWidget: RatingWidget(
              full: SvgPicture.asset(
                'assets/icons/star.svg',
              ),
              half: SvgPicture.asset(
                'assets/icons/rate.svg',
              ),
              empty: SvgPicture.asset(
                'assets/icons/rate.svg',
              ),
            ),
            glow: false,
            itemPadding: const EdgeInsets.symmetric(horizontal: 10),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
            updateOnDrag: true,
          ),
          const SizedBox(
            height: 29,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    enableFeedback: false,
                    side: BorderSide.none,
                    elevation: 0,
                    primary: Colors.transparent,
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
                    'Not now',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrderBloc>()
                        .add(RateRestaurant(widget.restaurantId, _rating));
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
                    'Rate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
