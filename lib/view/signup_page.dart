import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_strings.dart';
import 'package:immence_task/app_constants/app_text_style.dart';
import 'package:immence_task/models/users_provider.dart';
import 'package:immence_task/view/home_page.dart';
import 'package:immence_task/view/login_page.dart';
import 'package:immence_task/view/widgets/custom_button.dart';
import 'package:immence_task/view/widgets/custom_textfield.dart';
import 'package:immence_task/view/widgets/remember_me_checkbox.dart';
import 'package:provider/provider.dart';

import '../models/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

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
              CustomTextfield(
                controller: nameController,
                text: AppStrings.name,
                hintText: AppStrings.nameHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: emailController,
                text: AppStrings.emailAddress,
                hintText: AppStrings.emailAddressHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: phoneNumberController,
                text: AppStrings.phone,
                hintText: AppStrings.phoneHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: passwordController,
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
                child: CustomButton(
                  text: AppStrings.signUp,
                  onPress: () async {
                    final authService =
                        Provider.of<AuthProvider>(context, listen: false);
                    await authService.createNewUser(
                      context: context,
                      name: nameController.text.trim(),
                      phone: phoneNumberController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      onSuccess: (email, phone, name) async {
                        UserProvider userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        await userProvider.storeUserData(
                          email: email,
                          phone: phone,
                          name: name,
                          onSuccess: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                        );
                      },
                      onError: (String error) {
                        FlutterToastr.show(error, context, duration: 3);
                      },
                    );
                  },
                ),
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
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false);
          },
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
      ),
    );
  }
}
