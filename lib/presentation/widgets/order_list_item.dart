import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/price_text.dart';
import 'package:food_delivery_app/presentation/widgets/quantity_operation_container.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class OrderListItem extends StatelessWidget {
  final Menu dish;
  final int itemQuantity;
  final bool isOrder;
  const OrderListItem({
    required this.dish,
    required this.itemQuantity,
    required this.isOrder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.cyan,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(dish.dishImage),
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dish.dishName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  dish.dishIngredients,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (isOrder)
                  // if (isOrder == true)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<OrderBloc>().add(
                                RemoveDish(dish),
                              );
                        },
                        child: QuantityOperationContainer(
                          shadow: true,
                          size: 28,
                          icon: SvgPicture.asset(
                            'assets/icons/minus1.svg',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '$itemQuantity',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<OrderBloc>().add(
                                AddDish(dish),
                              );
                        },
                        child: QuantityOperationContainer(
                          shadow: true,
                          size: 28,
                          icon: SvgPicture.asset(
                            'assets/icons/plus.svg',
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bowl.svg',
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('x$itemQuantity'),
                    ],
                  ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceText(
                textSize: 18,
                itemPrice: dish.dishPrice,
              ),
              if (isOrder)
                // if (isOrder == true)
                GestureDetector(
                  onTap: () {
                    context.read<OrderBloc>().add(
                          RemoveAllDishes(dish),
                        );
                  },
                  child: QuantityOperationContainer(
                    shadow: false,
                    size: 28,
                    icon: SvgPicture.asset(
                      'assets/icons/basket.svg',
                      color: AppColors.grey,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
