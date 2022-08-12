import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/get_out_bottom_sheet.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

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
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is UserLoaded) {
              return ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (nameController.text.isNotEmpty ||
                            emailController.text.isNotEmpty) {
                          showModalBottomSheet<Widget?>(
                            useRootNavigator: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return GetoutBottomSheet(callback: () {
                                nameController.clear();
                                emailController.clear();
                                context.router.popUntilRoot();
                              });
                            },
                          );
                        } else {
                          context.router.pop();
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/icons/login_back_button.svg',
                      ),
                    ),
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
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: state.usersInfo.name == ''
                          ? 'First and last name'
                          : state.usersInfo.name,
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  TextField(
                    controller: phonenumberController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 12,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: state.usersInfo.phoneNumber, //'Phone number',
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 12,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: state.usersInfo.email == ''
                          ? 'Email'
                          : state.usersInfo.email,
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  TextField(
                    controller: idController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 12,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: state.usersInfo.userId, //'Identity number',
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty) {
                        context.read<UserBloc>().add(CreateCurrentUser(
                              nameController.text,
                              emailController.text,
                            ));
                        context.router
                            .replace(HomeRoute(userId: state.usersInfo.userId));
                      }
                      // ignore: unnecessary_statements
                      null;
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.orange,
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.grey),
                      ),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
