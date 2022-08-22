import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/get_out_bottom_sheet.dart';
import 'package:food_delivery_app/presentation/widgets/quantity_operation_container.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class TimeSelectPage extends StatefulWidget {
  final Timestamp openHour;
  final Timestamp closeHour;
  final bool isOrder;
  final String restaurantName;
  final String restaurantImage;
  final String restaurantId;
  const TimeSelectPage({
    required this.openHour,
    required this.closeHour,
    required this.isOrder,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    Key? key,
  }) : super(key: key);

  @override
  State<TimeSelectPage> createState() => _TimeSelectPageState();
}

class _TimeSelectPageState extends State<TimeSelectPage> {
  List<DateTime> workHours = [];
  int guestCounter = 1;
  String selectedDateString = DateFormat('dd.MM.yyyy').format(DateTime.now());

  @override
  void initState() {
    generateHours();
    super.initState();
  }

  void generateHours() {
    final start = widget.openHour.toDate();
    final end = widget.closeHour.toDate();

    final hourDiff = end.difference(start).inMinutes;
    print('\x1B[33m$hourDiff\x1B[0m');
    workHours = List<DateTime>.generate(
      hourDiff,
      (i) => DateTime(
        DateTime.now().hour,
        DateTime.now().minute,
      ).add(Duration(minutes: i * 30)),
    );
    //print YEllow TExt
    print('\x1B[33m$workHours\x1B[0m');
  }

  final commentController = TextEditingController();

  DateTime? pickedItem;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  final state = context.read<OrderBloc>().state;

                  if (state is OrderLoaded) {
                    if (pickedItem != null || selectedDate != null) {
                      showModalBottomSheet<Widget?>(
                        useRootNavigator: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return GetoutBottomSheet(callback: () {
                            state.order.dishes.forEach((element) {
                              context.read<OrderBloc>().add(
                                    RemoveAllDishes(element),
                                  );
                            });
                            context.router.popUntilRoot();
                          });
                        },
                      );
                    } else {
                      context.router.pop();
                      state.order.dishes.forEach((element) {
                        context.read<OrderBloc>().add(
                              RemoveAllDishes(element),
                            );
                      });
                    }
                  } else {
                    context.router.pop();
                  }
                },
                child: SvgPicture.asset(
                  'assets/icons/login_back_button.svg',
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Menu ${widget.restaurantName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Food in the restaurant. Takeaway food. No delivery',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDateString =
                          DateFormat('dd.MM.yyyy').format(pickedDate!);
                    });
                  } else {
                    pickedDate = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    );
                  }

                  selectedDate = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedItem?.hour ?? DateTime.now().hour,
                    pickedItem?.minute ?? DateTime.now().minute,
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                      ),
                      width: 2,
                      color: AppColors.lightGrey,
                    ),
                    Text(
                      selectedDateString,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              width: double.infinity,
              height: 220,
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: workHours.length,
                itemBuilder: (context, index) {
                  final hour = workHours[index];

                  return InkWell(
                    onTap: () {
                      setState(
                        () {
                          pickedItem = hour;
                        },
                      );
                      selectedDate = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        pickedItem?.hour ?? DateTime.now().hour,
                        pickedItem?.minute ?? DateTime.now().minute,
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 38,
                      decoration: BoxDecoration(
                        color: hour == pickedItem
                            ? AppColors.orange
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(
                        child: Text(
                          DateFormat('HH:mm').format(hour),
                          style: TextStyle(
                            color: hour == pickedItem
                                ? Colors.white
                                : Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Number of guests',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            guestCounter == 0 ? null : guestCounter--;
                          });
                        },
                        child: QuantityOperationContainer(
                          shadow: false,
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
                        '$guestCounter',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            guestCounter++;
                          });
                        },
                        child: QuantityOperationContainer(
                          shadow: false,
                          size: 28,
                          icon: SvgPicture.asset(
                            'assets/icons/plus.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/add_dish.svg',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Add dishes (optional)',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              controller: commentController,
              style: const TextStyle(
                color: AppColors.grey,
              ),
              decoration: const InputDecoration(
                hintText: 'Your comments',
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(MenuRoute(
                  restaurantId: widget.restaurantId,
                  restaurantName: widget.restaurantName,
                  restaurantImage: widget.restaurantImage,
                  isOrder: true,
                  selectedDate: selectedDate,
                  numberOfGuests: guestCounter,
                ));
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
