import 'package:flutter/material.dart';

import 'package:food_delivery_app/data/models/ordered_dishes.dart';
import 'package:food_delivery_app/presentation/widgets/dash_separator.dart';
import 'package:food_delivery_app/presentation/widgets/order_list_item.dart';
import 'package:food_delivery_app/presentation/widgets/price_text.dart';

class BookingOrderBottomSheet extends StatelessWidget {
  final List<OrderedDishes> orderedDishes;
  final num totalPrice;
  const BookingOrderBottomSheet({
    required this.orderedDishes,
    required this.totalPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 4,
            ),
          ),
          const Text(
            'Order',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const DashSeparator(),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: orderedDishes.length,
              itemBuilder: (context, index) {
                return OrderListItem(
                  dish: orderedDishes[index].dish,
                  itemQuantity: orderedDishes[index].quantity,
                  isOrder: false,
                );
              },
            ),
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
                itemPrice: totalPrice,
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
