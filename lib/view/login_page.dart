import 'package:flutter/material.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_strings.dart';
import 'package:immence_task/app_constants/app_text_style.dart';
import 'package:immence_task/view/signup_page.dart';
import 'package:immence_task/view/widgets/custom_button.dart';
import 'package:immence_task/view/widgets/custom_textfield.dart';
import 'package:immence_task/view/widgets/remember_me_checkbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  bool isObsecure = true;

  _notify([Function? function]) {
    if (mounted) {
      setState(
        () {
          function?.call();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.immence, style: AppTextStyle.titleText),
              const SizedBox(
                height: 41.7,
              ),
              const Text(
                AppStrings.welcomeLine,
                style: AppTextStyle.headingText,
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomTextfield(
                text: AppStrings.email,
                hintText: AppStrings.emailHint,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextfield(
                text: AppStrings.password,
                isObsecure: isObsecure,
                hintText: AppStrings.passwordHint,
                trailing: GestureDetector(
                  onTap: () {
                    isObsecure = !isObsecure;
                    _notify();
                  },
                  child: isObsecure
                      ? const Icon(
                          Icons.visibility,
                          size: 18,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          size: 18,
                        ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              RememberMeCheckBox(
                value: isChecked,
                onChange: (value) {
                  isChecked = value;
                  _notify();
                },
              ),
              const SizedBox(
                height: 28,
              ),
              Flexible(
                child: CustomButton(text: AppStrings.login, onPress: () {}),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ));
          },
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: AppStrings.dontHaveAnAccount,
                  style: AppTextStyle.hintStyle,
                ),
                const TextSpan(text: "  "),
                TextSpan(
                  text: AppStrings.signUp,
                  style: AppTextStyle.buttonText.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
