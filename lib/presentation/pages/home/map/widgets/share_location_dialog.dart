import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ShareLocationDialog extends StatelessWidget {
  const ShareLocationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/geo.svg',
            ),
            const SizedBox(height: 16),
            const Text(
              'Share your geolocation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
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
                      'Deny',
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
                      context.read<LocationBloc>().add(PermissionRequest());
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
                      'Share',
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
      ),
    );
  }
}
