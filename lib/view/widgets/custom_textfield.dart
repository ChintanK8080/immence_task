import 'package:flutter/material.dart';
import 'package:immence_task/app_constants/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.text,
      required this.hintText,
      this.trailing,
      this.isObsecure = false});
  final String text;
  final String hintText;
  final Widget? trailing;
  final bool isObsecure;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          height: 41,
          child: TextField(
            obscureText: widget.isObsecure,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(color: const Color(0xff1F1F1F).withOpacity(0.41)),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                suffix: widget.trailing),
          ),
        ),
      ],
    );
  }
}
