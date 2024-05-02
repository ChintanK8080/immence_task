import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immence_task/app_constants/app_assets.dart';
import 'package:immence_task/app_constants/app_colors.dart';
import 'package:immence_task/app_constants/app_strings.dart';
import 'package:immence_task/app_constants/app_text_style.dart';
import 'package:immence_task/models/auth_provider.dart';
import 'package:immence_task/models/users_provider.dart';
import 'package:immence_task/view/widgets/profile_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getAllUserData();
    userProvider.getCurrentUserData();
    super.initState();
  }

  // getUserdata() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
   
  //   final userData = pref.getString("UserData");
  //   log(userData ?? 'llll');
  // }

  @override
  Widget build(BuildContext context) {
    // getUserdata();
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    log(userProvider.name.toString());
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 31),
                    child:
                        Text(AppStrings.immence, style: AppTextStyle.titleText),
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 31,
                    ),
                    child: Text(
                      AppStrings.users,
                      style: AppTextStyle.headingText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        tileColor: AppColors.white,
                        title: Text(
                          userProvider.userDataList[index]["name"],
                          style: AppTextStyle.headingText3,
                        ),
                        subtitle: Text(
                          userProvider.userDataList[index]["email"],
                          style: AppTextStyle.hintStyle,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.1)),
                          child: Text(
                            "L",
                            style: AppTextStyle.headingText3.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: userProvider.userDataList.length,
                  ),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 141,
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withOpacity(0.05)),
                  child: SvgPicture.asset(
                    AppAssets.appLogo,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  userProvider.name ?? '',
                  style: AppTextStyle.headingText2,
                ),
                const SizedBox(
                  height: 19,
                ),
                ProfileTile(
                  prefix: "Email",
                  suffixText: userProvider.email ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTile(
                  prefix: "Phone No.",
                  suffixText: userProvider.phone ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTile(
                  prefix: "Log out",
                  suffixWidget: GestureDetector(
                    onTap: () async {
                      authProvider.logout(context);
                    },
                    child: const Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        tabs: const [
          Icon(
            CupertinoIcons.group,
            color: AppColors.primaryColor,
          ),
          Icon(
            CupertinoIcons.person,
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
