import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/widgets/selected_dish_bottom_sheet.dart';
import 'package:food_delivery_app/presentation/widgets/price_text.dart';
import 'package:food_delivery_app/presentation/widgets/quantity_operation_container.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class MenuGridItem extends StatefulWidget {
  final bool isOrder;
  final Menu menuItem;
  const MenuGridItem({required this.isOrder, required this.menuItem, Key? key})
      : super(key: key);

  @override
  State<MenuGridItem> createState() => _MenuGridItemState();
}

class _MenuGridItemState extends State<MenuGridItem> {
  ValueNotifier<int> s = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    // var a = s;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Widget?>(
          isScrollControlled: true,
          useRootNavigator: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          context: context,
          builder: (context) {
            return SelectedDishBottomSheet(menuItem: widget.menuItem);
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.menuItem.dishImage,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            // 'Grilled Prawn',
            widget.menuItem.dishName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            // 'Grilled King Prawn, Couscous, Prawn Bisque',
            widget.menuItem.dishIngredients,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceText(
                textSize: 18,
                itemPrice: widget.menuItem.dishPrice,
              ),
              if (!widget.isOrder)
                // if (widget.isOrder == false)
                const SizedBox.shrink()
              else
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoaded) {
                      return GestureDetector(
                        onTap: () {
                          if (state.order.dishes.contains(widget.menuItem)) {
                            context
                                .read<OrderBloc>()
                                .add(RemoveDish(widget.menuItem));
                          } else {
                            context
                                .read<OrderBloc>()
                                .add(AddDish(widget.menuItem));
                          }
                        },
                        child: QuantityOperationContainer(
                          icon: state.order.dishes.contains(widget.menuItem)
                              ? SvgPicture.asset(
                                  'assets/icons/basket.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                ),
                          size: 28,
                          shadow: true,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
