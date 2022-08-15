// ignore_for_file: avoid_bool_literals_in_conditional_expressions
// ignore_for_file: no-boolean-literal-compare

import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';

import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _textEditingController = TextEditingController();
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
              isRegistration: false,
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
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: numberLentghError == false &&
                          _textEditingController.text.isNotEmpty
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
                    'Sign in',
                    style: TextStyle(
                      color: !numberLentghError ? Colors.white : AppColors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (Platform.isIOS)
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
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PhoneAuthBloc>()
                          .add(OnPhoneAuthGoogleSignIn());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/google.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Don`t have an account?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    context.router.push(const EnterPhoneRoute());
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      shadows: [
                        Shadow(color: AppColors.orange, offset: Offset(0, -5)),
                      ],
                      decoration: TextDecoration.underline,
                      decorationThickness: 4,
                      decorationColor: AppColors.orange,
                      color: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _sendOtp() {
    final phoneNumberWithCode = _textEditingController.text; //phoneNumber;
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
            isRegistration: false,
          ),
        );
  }
}
