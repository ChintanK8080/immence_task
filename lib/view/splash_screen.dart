import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immence_task/app_constants/app_assets.dart';
import 'package:immence_task/view_models/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.authenticateUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SvgPicture.asset(AppAssets.appLogo),
      ),
    );
  }
}
