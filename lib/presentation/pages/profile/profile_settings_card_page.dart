import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/payment_method.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ProfileSettingsCardPage extends StatefulWidget {
  final List<PaymentMethod> paymentCard;
  final String mainCard;
  const ProfileSettingsCardPage({
    required this.paymentCard,
    required this.mainCard,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileSettingsCardPage> createState() =>
      _ProfileSettingsCardPageState();
}

class _ProfileSettingsCardPageState extends State<ProfileSettingsCardPage> {
  bool selectedCard = true;

  // ignore: long-method
  void showBottomSheet(PaymentMethod card) {
    showModalBottomSheet<Widget?>(
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 'Profile Settings',
                card.number,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(UpdateMainCard(card.number));
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
                  'Use as main',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  context.read<UserBloc>().add(RemoveCard(card));
                  context.router.pop();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
              'Payment Method',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return ListView.builder(
                      itemCount: state.usersInfo.paymentCards
                          ?.length, //widget.paymentCard.length,
                      itemBuilder: (context, index) {
                        final lastCardDigit = state
                            .usersInfo.paymentCards?[index].number
                            .substring(
                          state.usersInfo.paymentCards![index].number.length -
                              4,
                        );

                        return TextField(
                          readOnly: true,
                          style: const TextStyle(),
                          decoration: InputDecoration(
                            suffixIcon: Checkbox(
                              shape: const CircleBorder(),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.green;
                                  }

                                  return AppColors.grey;
                                },
                              ),
                              value:
                                  state.usersInfo.paymentCards?[index].number ==
                                          state.usersInfo.mainCard
                                      ? selectedCard
                                      : !selectedCard,
                              onChanged: (value) {
                                setState(() {
                                  // selectedCard = value ?? false;
                                  showBottomSheet(
                                    state.usersInfo.paymentCards?[index] ??
                                        const PaymentMethod(
                                          number: '',
                                          validUntil: '',
                                          cvv: '',
                                        ),
                                  );
                                });
                              },
                            ),
                            labelText: 'Payment Card',
                            hintText: 'Visa xxxx ${lastCardDigit}',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            labelStyle: const TextStyle(color: AppColors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.grey, width: 2),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.grey, width: 2),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.router.push(const AddNewCardRoute()),
              style: ElevatedButton.styleFrom(
                primary: AppColors.orange,
                fixedSize: Size(MediaQuery.of(context).size.width, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add new card',
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
