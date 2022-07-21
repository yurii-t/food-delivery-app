import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
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
                controller: _textEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLength: 12,
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
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: (_textEditingController.text.length < 12)
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
              Platform.isIOS
                  ? Row(
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
                                  side:
                                      const BorderSide(color: AppColors.grey)),
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
                                  side:
                                      const BorderSide(color: AppColors.grey)),
                            ),
                            child: SvgPicture.asset('assets/icons/google.svg'),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        fixedSize: Size(MediaQuery.of(context).size.width, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.grey)),
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
              const Text(
                'Sign up',
                style: TextStyle(
                  shadows: [
                    Shadow(color: AppColors.orange, offset: Offset(0, -5))
                  ],
                  decoration: TextDecoration.underline,
                  decorationThickness: 4,
                  decorationColor: AppColors.orange,
                  color: Colors.transparent,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ));
  }
}
