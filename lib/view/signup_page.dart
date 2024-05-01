import 'package:flutter/material.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_strings.dart';
import 'package:immence_task/app_constants/app_text_style.dart';
import 'package:immence_task/view/widgets/custom_button.dart';
import 'package:immence_task/view/widgets/custom_textfield.dart';
import 'package:immence_task/view/widgets/remember_me_checkbox.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;

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
                AppStrings.createAnAccount,
                style: AppTextStyle.headingText,
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomTextfield(
                text: AppStrings.name,
                hintText: AppStrings.nameHint,
              ),
              const SizedBox(
                height: 9,
              ),
              const CustomTextfield(
                text: AppStrings.emailAddress,
                hintText: AppStrings.emailAddressHint,
              ),
              const SizedBox(
                height: 9,
              ),
              const CustomTextfield(
                text: AppStrings.phone,
                hintText: AppStrings.phoneHint,
              ),
              const SizedBox(
                height: 9,
              ),
              const CustomTextfield(
                text: AppStrings.password,
                hintText: AppStrings.passwordHint,
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
                child: CustomButton(text: AppStrings.signUp, onPress: () {}),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: AppStrings.alreadyHaveAnAccount,
                style: AppTextStyle.hintStyle,
              ),
              const TextSpan(text: "  "),
              TextSpan(
                text: AppStrings.login,
                style: AppTextStyle.buttonText.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
