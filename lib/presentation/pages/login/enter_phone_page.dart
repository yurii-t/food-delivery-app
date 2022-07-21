import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class EnterPhonePage extends StatefulWidget {
  const EnterPhonePage({Key? key}) : super(key: key);

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  final _textEditingController = TextEditingController();
  bool isCheckedUserAgreement = false;
  bool isCheckedPrivacyPolicy = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocSelector<PhoneAuthBloc, PhoneAuthState, bool>(
            selector: (state) {
          if (state is PhoneAuthCodeSentSuccess) {
            context.router.push(EnterPinRoute(
              verId: state.verificationId,
            ));
          }
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          return state is PhoneAuthLoading;
        }, builder: (context, showLoading) {
          return Container(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 120,
            ), // bottom: 48),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Qpay',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 60),
                  ),
                ),
                const SizedBox(
                  height: 54,
                ),
                TextField(
                  // onChanged: (number){

                  // },
                  controller: _textEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  maxLength: 13,
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Phone number',
                    labelStyle: TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.white),
                      ),
                      focusColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return Colors.white;
                      }),
                      value: isCheckedUserAgreement,
                      onChanged: (value) {
                        setState(() {
                          isCheckedUserAgreement = value!;
                        });
                      },
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree with the terms of the',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'User Agreement',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.white, offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationThickness: 4,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => (isCheckedPrivacyPolicy == false &&
                                _textEditingController.text.isNotEmpty)
                            ? const BorderSide(width: 1.0, color: Colors.red)
                            : const BorderSide(width: 1.0, color: Colors.white),
                      ),
                      focusColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return Colors.white;
                      }),
                      value: isCheckedPrivacyPolicy,
                      onChanged: (value) {
                        setState(() {
                          isCheckedPrivacyPolicy = value!;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree with the terms of the',
                            style: TextStyle(
                              color: (isCheckedPrivacyPolicy == false &&
                                      _textEditingController.text.isNotEmpty)
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: (isCheckedPrivacyPolicy == false &&
                                      _textEditingController.text.isNotEmpty)
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
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
                  onPressed: _sendOtp,
                  style: ElevatedButton.styleFrom(
                    primary: (_textEditingController.text.length < 12 &&
                            isCheckedUserAgreement == false &&
                            isCheckedPrivacyPolicy == false)
                        ? Colors.transparent
                        : AppColors.orange,
                    fixedSize: Size(MediaQuery.of(context).size.width, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.grey)),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: _textEditingController.text.length < 12
                          ? AppColors.grey
                          : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: AppColors.grey)),
                        ),
                        child: SvgPicture.asset('assets/icons/apple.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: AppColors.grey)),
                        ),
                        child: SvgPicture.asset('assets/icons/google.svg'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }

  void _sendOtp() {
    final phoneNumberWithCode = _textEditingController.text; //phoneNumber;
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
          ),
        );
  }
}
