import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class SupportServicePage extends StatefulWidget {
  const SupportServicePage({Key? key}) : super(key: key);

  @override
  State<SupportServicePage> createState() => _SupportServicePageState();
}

class _SupportServicePageState extends State<SupportServicePage> {
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding:
            // const EdgeInsets.all(0),
            const EdgeInsets.only(left: 16, right: 16, top: 36),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => context.router.pop(),
                child: SvgPicture.asset(
                  'assets/icons/login_back_button.svg',
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Support Service',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'If you have any questions, the Qpay\ninformation and reference service is always ready to help. Write to us!',
              textAlign: TextAlign.start,
              style: TextStyle(
                // color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: ' Your comments',
                // hintText: 'MasterCard xxxx 1111',
                hintStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(SendSupportMessage(
                      emailController.text,
                      messageController.text,
                    ));
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
                            'Message sent. The answer will be\nsent to the mail within two days.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                              emailController.clear();
                              messageController.clear();
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
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.orange,
                fixedSize: Size(MediaQuery.of(context).size.width, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
