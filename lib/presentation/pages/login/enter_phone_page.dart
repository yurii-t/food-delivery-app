// ignore_for_file: avoid_bool_literals_in_conditional_expressions
// ignore_for_file: no-boolean-literal-compare

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
  bool numberLentghError = false;

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
              isRegistration: true,
              phoneNumber: _textEditingController.text,
            ));
          }
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          if (state is PhoneAuthPhoneNumberExist) {
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
                    children: [
                      const Text(
                        'A user with this number is already\nregistered. Log in to the app, please',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      ElevatedButton(
                        onPressed: () {
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
                          'Okay',
                          style: TextStyle(
                            color: Colors.white,
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

          return state is PhoneAuthLoading;
        },
        builder: (context, showLoading) {
          return Container(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 120,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.fill,
              ),
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
                      fontSize: 30,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Qpay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 54,
                ),
                TextField(
                  onSubmitted: (value) {
                    setState(() {
                      numberLentghError = value.length < 13 ? true : false;
                    });
                  },
                  controller: _textEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  maxLength: 13,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Phone number',
                    labelStyle: const TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    errorText: numberLentghError == false
                        ? null
                        : 'Invalid phone number',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => !isCheckedUserAgreement &&
                                _textEditingController.text.isNotEmpty
                            ? const BorderSide(width: 1, color: Colors.red)
                            : const BorderSide(width: 1, color: Colors.white),
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
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree with the terms of the',
                            style: TextStyle(
                              color: !isCheckedUserAgreement &&
                                      _textEditingController.text.isNotEmpty
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'User Agreement',
                            style: TextStyle(
                              color: !isCheckedUserAgreement &&
                                      _textEditingController.text.isNotEmpty
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
                Row(
                  children: [
                    Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => !isCheckedPrivacyPolicy &&
                                _textEditingController.text.isNotEmpty
                            ? const BorderSide(width: 1, color: Colors.red)
                            : const BorderSide(width: 1, color: Colors.white),
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
                              color: !isCheckedPrivacyPolicy &&
                                      _textEditingController.text.isNotEmpty
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: !isCheckedPrivacyPolicy &&
                                      _textEditingController.text.isNotEmpty
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
                  onPressed: numberLentghError == false &&
                          isCheckedPrivacyPolicy &&
                          isCheckedUserAgreement
                      ? _sendOtp
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.orange,
                    fixedSize: Size(MediaQuery.of(context).size.width, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.grey),
                    ),
                  ),
                  child: Text(
                    'Send code',
                    style: TextStyle(
                      color: numberLentghError == false &&
                              isCheckedPrivacyPolicy &&
                              isCheckedUserAgreement
                          ? Colors.white
                          : AppColors.grey,
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
                        onPressed: () => null,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.grey),
                          ),
                        ),
                        child: SvgPicture.asset('assets/icons/apple.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<PhoneAuthBloc>()
                              .add(OnPhoneAuthGoogleSignIn());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.grey),
                          ),
                        ),
                        child: SvgPicture.asset('assets/icons/google.svg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _sendOtp() {
    final phoneNumberWithCode = _textEditingController.text;
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
            isRegistration: true,
          ),
        );
  }
}
