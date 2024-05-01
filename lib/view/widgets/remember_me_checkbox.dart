import 'package:flutter/material.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_strings.dart';
import 'package:immence_task/app_constants/app_text_style.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({
    super.key,
    required this.value,
    required this.onChange,
  });
  final bool value;
  final Function(bool value) onChange;

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool isChecked = false;
  @override
  void initState() {
    isChecked = widget.value;
    super.initState();
  }

  _notify([Function? fucntion]) {
    if (mounted) {
      setState(() {
        fucntion?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          checkColor: AppColors.primaryColor,
          activeColor: AppColors.black.withOpacity(0.1),
          side: const BorderSide(
            color: AppColors.black,
          ),
          onChanged: (value) {
            isChecked = value ?? false;
            widget.onChange(isChecked);
            _notify();
          },
        ),
        Text(
          AppStrings.remeberMe,
          style: AppTextStyle.buttonText.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
