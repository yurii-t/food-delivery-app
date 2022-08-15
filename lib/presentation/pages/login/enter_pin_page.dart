import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';

import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterPinPage extends StatefulWidget {
  final String verId;
  final bool isRegistration;
  final String phoneNumber;
  const EnterPinPage({
    required this.verId,
    required this.isRegistration,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  final TextEditingController _pinController = TextEditingController();
  int time = 60;
  late Timer _timer;

  void startTimer() {
    const onsec = Duration(seconds: 1);

    _timer = Timer.periodic(onsec, (timer) {
      if (time == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String minutesStr =
        ((time / 60) % 60).floor().toString().padLeft(2, '0');
    final String secondsStr = (time % 60).floor().toString().padLeft(2, '0');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthVerified) {
            context
                .read<AuthStatusBloc>()
                .add(AuthStatusLogedIn(isRegistration: widget.isRegistration));
          }

          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Container(
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
              Center(
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(color: Colors.white),
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    selectedColor: AppColors.orange,
                    inactiveColor: Colors.white,
                    activeColor: AppColors.orange,
                    errorBorderColor: Colors.red,
                  ),
                  animationDuration: const Duration(milliseconds: 100),
                  enableActiveFill: false,
                  controller: _pinController,
                  onCompleted: (v) {
                    print('Completed');
                    _verifyOtp(verificationId: widget.verId);
                  },
                  onChanged: print,
                  beforeTextPaste: (text) {
                    print('Allowing to paste $text');

                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 41,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // ignore: unnecessary_statements
                        time == 0 ? _sendOtp() : null;
                      },
                      child: Text(
                        'Resend the code',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: time == 0 ? AppColors.orange : AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '$minutesStr:$secondsStr',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyOtp({required String verificationId}) {
    context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
          otpCode: _pinController.text,
          verificationId: verificationId,
        ));
  }

  void _sendOtp() {
    final phoneNumberWithCode = widget.phoneNumber;
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
            isRegistration: false,
          ),
        );
  }
}
