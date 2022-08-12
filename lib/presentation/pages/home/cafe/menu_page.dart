import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:food_delivery_app/data/models/menu_category.dart';
import 'package:food_delivery_app/presentation/blocs/menu/bloc/menu_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/widgets/menu_grid_item.dart';

import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class MenuPage extends StatefulWidget {
  final bool isOrder;
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final DateTime? selectedDate;
  final num? numberOfGuests;
  const MenuPage({
    required this.isOrder,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    this.selectedDate,
    this.numberOfGuests,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    context.read<MenuBloc>().add(LoadMenu(widget.restaurantId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is MenuLoaded) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/login_back_button.svg',
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.restaurantName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          itemCount: state.categoryList.length,
                          // itemExtent: 98,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                if (state.selectedCategory ==
                                    state.categoryList[index]) {
                                  context
                                      .read<MenuBloc>()
                                      .add(const SelectMenuCategory(
                                        MenuCategory(categories: ''),
                                      ));
                                } else {
                                  context
                                      .read<MenuBloc>()
                                      .add(SelectMenuCategory(
                                        state.categoryList[index],
                                      ));
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 8,
                                  left: 8,
                                  bottom: 16,
                                ),
                                height: 26,
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 4,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: state.selectedCategory ==
                                          state.categoryList[index]
                                      ? AppColors.darkBlue
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    state.categoryList[index].categories,
                                    style: TextStyle(
                                      color: state.selectedCategory ==
                                              state.categoryList[index]
                                          //index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            // childAspectRatio: 1 / 1,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 200,
                          ),
                          itemCount: state.menuItems.length,
                          itemBuilder: (ctx, index) {
                            final menuItem = state.menuItems[index];

                            return MenuGridItem(
                              isOrder: widget.isOrder,
                              menuItem: menuItem,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: !widget.isOrder
                      // child: widget.isOrder == false
                      ? Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Please, return to the main screen\nof the restaurant to make an order',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            if (state is OrderLoaded) {
                              final int itemQuantity = state.order
                                  .itemQuantity(state.order.dishes)
                                  .entries
                                  .fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue + (element.value as int),
                                  );

                              return state.order.dishes.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        context.router.push(CartRoute(
                                          restaurantId: widget.restaurantId,
                                          restaurantName: widget.restaurantName,
                                          restaurantImage:
                                              widget.restaurantImage,
                                          //TODO:
                                          bookedTime: Timestamp.fromDate(
                                            widget.selectedDate ??
                                                DateTime.now(),
                                          ),
                                          numberofGuests:
                                              widget.numberOfGuests ?? 1,
                                        ));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 140,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.orange,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/bill.svg',
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      '${state.order.totalPrice.toInt()}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: const Offset(2, -8),
                                                    child: const Text(
                                                      'R',
                                                      //superscript is usually smaller in size
                                                      textScaleFactor: 0.7,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              width: 28,
                                              height: 28,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: AppColors.darkBlue,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '$itemQuantity',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
