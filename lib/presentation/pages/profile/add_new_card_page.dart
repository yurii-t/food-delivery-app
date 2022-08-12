import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/payment_method.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';

import 'package:food_delivery_app/theme/app_colors.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final cardNumberController = TextEditingController();
  final cardCvvController = TextEditingController();
  final cardYearController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardCvvController.dispose();
    cardYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: SvgPicture.asset(
                'assets/icons/login_back_button.svg',
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add a new card',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: cardNumberController,
              style: const TextStyle(),
              decoration: const InputDecoration(
                labelText: 'Number',
                // hintText: 'MasterCard xxxx 1111',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: TextStyle(color: AppColors.grey),
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
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cardYearController,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Valid until',
                      // hintText: 'MasterCard xxxx 1111',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      labelStyle: TextStyle(color: AppColors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: cardCvvController,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      // hintText: 'MasterCard xxxx 1111',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      labelStyle: TextStyle(color: AppColors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(AddCard(PaymentMethod(
                      number: cardNumberController.text,
                      validUntil: cardYearController.text,
                      cvv: cardCvvController.text,
                    )));

                cardNumberController.clear();
                cardYearController.clear();
                cardCvvController.clear();
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.orange,
                fixedSize: Size(MediaQuery.of(context).size.width, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
