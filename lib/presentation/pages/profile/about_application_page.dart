import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/profile_divider.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({Key? key}) : super(key: key);

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
              onTap: () => context.router.pop(),
              child: SvgPicture.asset(
                'assets/icons/login_back_button.svg',
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'About application',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'A program designed to perform certain\ntasks and designed for direct interaction\nwith the user. A program designed to\nperform certain tasks and designed for\ndirect interaction with the user.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const ProfileDivider(),
            const SizedBox(
              height: 34,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<Widget?>(
                  useRootNavigator: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: const [
                          Divider(
                            thickness: 4,
                            indent: 150,
                            endIndent: 150,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Privacy policy',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Text(
                            'This document "Privacy Policy" (hereinafter referred to as the "Policy") is the rules for the use of /specify the owner of the site/ (hereinafter referred to as "we" and/or "Administration") data of Internet users (hereinafter referred to as "you" and/or "User") collected using the site  / specify the URL of the site/ (hereinafter referred to as the "Site")',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Text(
                            '1. Processed data',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Text(
                            '1.1. We do not collect your personal data using the Website.\n\n1.2. All data collected on the Website is provided and accepted in an impersonal form (hereinafter referred to as "Impersonal Data").\n\n1.3. Depersonalized data includes the following information that does not allow you to be identified:\n\n1.3.1. Information that you provide about yourself using online forms and software modules of the Site, including your name or phone number and / or email address.\n\n1.3.2. Data that is transmitted in an impersonal form in automatic mode, depending on the settings of the software you use.\n\n1.4. The Administration has the right to establish requirements for the composition of Depersonalized User Data that is collected using the Site.\n\n1.5. If certain information is not marked as mandatory, its provision or disclosure is carried out by the User at his own discretion and on his own initiative.\n\n1.6. The Administration does not verify the accuracy of the data provided and whether the User has the necessary consent to their processing in accordance with this Policy, believing that the User acts in good faith, prudently and makes all necessary efforts to keep such information up to date and obtain all necessary consents to its use.',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Privacy policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/chevron_right.svg',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            const ProfileDivider(),
            const SizedBox(
              height: 34,
            ),
            GestureDetector(
              onTap: () {
                //https://pageflutter.com/privacy-policy/
                showModalBottomSheet<Widget?>(
                  useRootNavigator: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: const WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureRecognizers: {
                          Factory<VerticalDragGestureRecognizer>(
                            VerticalDragGestureRecognizer.new,
                          ),
                        },
                        initialUrl: 'https://pageflutter.com/privacy-policy/',
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'User agreement(webview)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/chevron_right.svg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
