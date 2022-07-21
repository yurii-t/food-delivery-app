import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final nameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phonenumberController.dispose();
    emailController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            top: 40,
          ), // bottom: 48),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
          ),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
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
                                const Text(
                                  ' Are you sure you want to get out?\nAll entered information will be lost',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 29,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide.none,
                                    elevation: 0,
                                    primary: AppColors.orange,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 52),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide.none,
                                    ),
                                  ),
                                  child: Text(
                                    'Stay here',
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
                                  onTap: () {},
                                  child: Text(
                                    'Get out',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child:
                        SvgPicture.asset('assets/icons/login_back_button.svg')),
              ),
              const SizedBox(
                height: 20,
              ),
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
              const Text(
                'To complete your registration, please enter your profile information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextField(
                controller: nameController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLength: 12,
                decoration: const InputDecoration(
                  focusColor: Colors.white,
                  labelText: 'First and last name',
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                ),
              ),
              TextField(
                controller: phonenumberController,
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
              TextField(
                controller: emailController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLength: 12,
                decoration: const InputDecoration(
                  focusColor: Colors.white,
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                ),
              ),
              TextField(
                controller: idController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLength: 12,
                decoration: const InputDecoration(
                  focusColor: Colors.white,
                  labelText: 'Identity number',
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
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: (nameController.text.isEmpty &&
                          emailController.text.isEmpty)
                      ? Colors.transparent
                      : AppColors.orange,
                  fixedSize: Size(MediaQuery.of(context).size.width, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.grey)),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: (nameController.text.isEmpty &&
                            emailController.text.isEmpty)
                        ? AppColors.grey
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
