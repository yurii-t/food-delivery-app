import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/price_text.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class SelectedDishBottomSheet extends StatefulWidget {
  final Menu menuItem;
  const SelectedDishBottomSheet({required this.menuItem, Key? key})
      : super(key: key);

  @override
  State<SelectedDishBottomSheet> createState() =>
      _SelectedDishBottomSheetState();
}

class _SelectedDishBottomSheetState extends State<SelectedDishBottomSheet> {
  List<Menu> bottomSheetDishQuantity = [];
  ValueNotifier<List<Menu>> quantityNotifier = ValueNotifier([]);
  int initLength = 0;
  @override
  void initState() {
    final state = context.read<OrderBloc>().state;
    if (state is OrderLoaded) {
      initLength = state.order.dishes.length;
    }

    super.initState();
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 4,
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.deepPurple,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.menuItem.dishImage,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.menuItem.dishName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              PriceText(
                textSize: 20,
                itemPrice: widget.menuItem.dishPrice,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.menuItem.dishIngredients,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bowl.svg',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.menuItem.weight.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 29,
              ),
              SvgPicture.asset(
                'assets/icons/fire.svg',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.menuItem.calories.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                builder: (
                  context,
                  list,
                  child,
                ) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          bottomSheetDishQuantity.remove(widget.menuItem);
                          quantityNotifier.value =
                              List.from(bottomSheetDishQuantity);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/minus.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${quantityNotifier.value.length + initLength}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          bottomSheetDishQuantity.add(widget.menuItem);

                          quantityNotifier.value =
                              List.from(bottomSheetDishQuantity);
                          print('DDD ${bottomSheetDishQuantity.length}');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/plus1.svg',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  quantityNotifier.value.forEach((element) {
                    context.read<OrderBloc>().add(
                          AddDish(element),
                        );
                  });
                  context.router.pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.orange,
                  fixedSize: const Size(
                    164,
                    52,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/shopping_cart1.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Add to order',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
