import 'package:flutter/material.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_text_style.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key, required this.prefix, this.suffixText, this.suffixWidget});
  final String prefix;
  final String? suffixText;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.hintTextColor,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prefix,
              style: AppTextStyle.bodyText,
            ),
            if (suffixText != null) ...[
              Text(
                suffixText!,
                style: AppTextStyle.labelStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            ] else if (suffixWidget != null) ...[
              suffixWidget!
            ]
          ],
        ),
      ),
    );
  }
}
