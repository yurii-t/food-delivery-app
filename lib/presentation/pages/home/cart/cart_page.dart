import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/data/models/ordered_dishes.dart';

import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/pages/home/cart/widgets/booked_bottom_sheet.dart';

import 'package:food_delivery_app/presentation/widgets/dash_separator.dart';
import 'package:food_delivery_app/presentation/widgets/order_list_item.dart';
import 'package:food_delivery_app/presentation/widgets/price_text.dart';

import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:food_delivery_app/util/random_string.dart';

class CartPage extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;

  final Timestamp bookedTime;
  final num numberofGuests;
  const CartPage({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.bookedTime,
    required this.numberofGuests,
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String paymentMethod = '';

  bool cashSelectedTab = false;
  bool cardSelectedTab = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
            if (state is OrderLoaded) {
              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      GestureDetector(
                        onTap: () {
                          state.order.dishes.forEach((element) {
                            context.read<OrderBloc>().add(
                                  RemoveAllDishes(element),
                                );
                          });
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/basket.svg',
                              color: AppColors.grey,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Delete all',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Order',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            // '25.07.2022',DateFormat('HH:mm').format(hour),
                            DateFormat('dd.MM.yyyy')
                                .format(widget.bookedTime.toDate()),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/clock.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            // '4:30',
                            DateFormat('HH:mm')
                                .format(widget.bookedTime.toDate()),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/users.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            // '2',
                            widget.numberofGuests.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const DashSeparator(),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      itemCount: state.order
                          .itemQuantity(state.order.dishes)
                          .keys
                          .length, //dishes.length,
                      itemBuilder: (context, index) {
                        final int itemQuantity = state.order
                            .itemQuantity(state.order.dishes)
                            .entries
                            .elementAt(index)
                            .value as int;
                        final Menu item = state.order
                            .itemQuantity(state.order.dishes)
                            .entries
                            .elementAt(index)
                            .key as Menu;

                        return OrderListItem(
                          dish: item,
                          itemQuantity: itemQuantity,
                          isOrder: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const DashSeparator(),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Price',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      PriceText(
                        textSize: 20,
                        itemPrice: state.order.totalPrice,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Payment',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Center(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cashSelectedTab = !cashSelectedTab;
                                  cardSelectedTab = false;
                                  paymentMethod = 'cash';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 8,
                                ),
                                height: 46,
                                width: 88,
                                decoration: BoxDecoration(
                                  // color: cashSelectedTab == false
                                  color: !cashSelectedTab
                                      ? Colors.white
                                      : AppColors.darkBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
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
                                    'Cash',
                                    style: TextStyle(
                                      color: cashSelectedTab
                                          // color: cashSelectedTab == true
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  cardSelectedTab = !cardSelectedTab;
                                  cashSelectedTab = false;
                                  paymentMethod = 'card';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 8,
                                ),
                                height: 46,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: cardSelectedTab
                                      // color: cardSelectedTab == true
                                      ? AppColors.darkBlue
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
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
                                    'Card',
                                    style: TextStyle(
                                      color: cardSelectedTab
                                          // color: cardSelectedTab == true
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final dishes = state.order
                          .itemQuantity(state.order.dishes)
                          .entries
                          .map((e) => OrderedDishes(
                                dish: e.key as Menu,
                                quantity: e.value as int,
                              ))
                          .toList();

                      context.read<OrderBloc>().add(AddBookingToFirebase(
                            Booking(
                              id: RandomString.getRandomString(),
                              dishes: dishes,
                              restaurantImage: widget.restaurantImage,
                              restaurantName: widget.restaurantName,
                              status: 'Confirmed',
                              totalPrice: state.order.totalPrice,
                              paymentMethod: paymentMethod,
                              bookedTime: widget.bookedTime,
                              numberofGuests: widget.numberofGuests,
                            ),
                          ));
                      showModalBottomSheet<Widget?>(
                        useRootNavigator: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return BookedBottomSheet(
                            restaurantId: widget.restaurantId,
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.orange,
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Book a table'),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
