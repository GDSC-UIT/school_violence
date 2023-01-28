import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_strings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:school_violence_app/app/modules/intro/widgets/loading_to_intro_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //wait 5 seconds to load to AuthPage

    loadingToIntroPage();

    //loading

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              width: 213,
              height: 450,
            ),
            Text(
              AppStrings().appName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 213,
              height: 100,
            ),
            const SpinKitCircle(
              color: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}
