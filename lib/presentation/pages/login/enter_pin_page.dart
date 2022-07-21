import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterPinPage extends StatefulWidget {
  final String verId;
  const EnterPinPage({required this.verId, Key? key}) : super(key: key);

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthVerified) {
                context.read<AuthStatusBloc>().add(AuthStatusLogedIn());
                context.router.replace(
                  HomeRoute(userId: state.uid),
                  // HomeRoute(userId: state.uid),
                );
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
                  Center(
                    child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(color: Colors.white),
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        // activeFillColor: Colors.white,
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
                        child: Text(
                          'Resend the code',
                          //TODO: whe timer 00;00 color orange
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: _pinController.text.isEmpty
                                  ? AppColors.grey
                                  : AppColors.orange),
                        ),
                      ),
                      Text(
                        '00:00',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void _verifyOtp({required String verificationId}) {
    context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
          otpCode: _pinController.text,
          verificationId: verificationId,
        ));
  }
}
