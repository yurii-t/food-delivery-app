import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/current_user.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/get_out_bottom_sheet.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ProfileSettingsPage extends StatefulWidget {
  final CurrentUser userInfo;
  const ProfileSettingsPage({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
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
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
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
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Profile Settings',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              style: const TextStyle(),
              maxLength: 12,
              decoration: InputDecoration(
                icon: SvgPicture.asset(
                  'assets/icons/user.svg',
                  color: AppColors.grey,
                ),
                labelText: 'First and last name',
                hintText: widget.userInfo.name,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: const TextStyle(color: AppColors.grey),
                floatingLabelBehavior: widget.userInfo.name.isEmpty
                    ? FloatingLabelBehavior.auto
                    : FloatingLabelBehavior.always,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
              ),
            ),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: phonenumberController,
              readOnly: true,
              style: const TextStyle(),
              maxLength: 12,
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 19),
                  child: SvgPicture.asset(
                    'assets/icons/calling.svg',
                    color: AppColors.grey,
                  ),
                ),
                labelText: 'Phone number',
                hintText: widget.userInfo.phoneNumber,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: const TextStyle(color: AppColors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/mail.svg',
                  color: AppColors.grey,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(),
                    maxLength: 12,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: 'Email',
                      hintText: widget.userInfo.email,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      labelStyle: const TextStyle(color: AppColors.grey),
                      floatingLabelBehavior: widget.userInfo.email.isEmpty
                          ? FloatingLabelBehavior.auto
                          : FloatingLabelBehavior.always,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              readOnly: true,
              controller: idController,
              style: const TextStyle(),
              decoration: InputDecoration(
                icon: SvgPicture.asset(
                  'assets/icons/id.svg',
                  color: AppColors.grey,
                ),
                labelText: 'Identity number',
                hintText: widget.userInfo.userId,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: const TextStyle(color: AppColors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 2),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(
                      UpdateUserInfo(nameController.text, emailController.text),
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
                'Save',
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
