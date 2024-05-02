import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immence_task/app_constants/app_assets.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_text_style.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key, required this.tabController});
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicator: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      tabs: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 10,
            ),
            SvgPicture.asset(
              AppAssets.users,
              colorFilter: ColorFilter.mode(
                  tabController?.index == 0
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  BlendMode.srcIn),
            ),
            Text(
              "Users",
              style: AppTextStyle.labelStyle.copyWith(
                color: tabController?.index == 0
                    ? AppColors.primaryColor
                    : AppColors.hintTextColor,
              ),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 10,
            ),
            SvgPicture.asset(
              AppAssets.user,
              colorFilter: ColorFilter.mode(
                  tabController?.index == 1
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  BlendMode.srcIn),
            ),
            Text(
              "User",
              style: AppTextStyle.labelStyle.copyWith(
                color: tabController?.index == 1
                    ? AppColors.primaryColor
                    : AppColors.hintTextColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
