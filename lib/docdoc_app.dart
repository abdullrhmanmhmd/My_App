
import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/ui/all_doctors/all_doctors_screen.dart';
import 'package:docdoc/ui/doctor_details/doctor_details_screen.dart';

import 'package:docdoc/ui/login/login_screen.dart';
import 'package:docdoc/ui/on_boarding/onboarding_screen.dart';
import 'package:docdoc/ui/profile/update_profile_screen.dart';
import 'package:docdoc/ui/screens/add_appointmemt_screen.dart';

// import 'package:docdoc/ui/screens/all_doctors_screen.dart';
// import 'package:docdoc/ui/screens/profile_screen.dart';

import 'package:docdoc/ui/signin/sign_up_screen.dart';
import 'package:docdoc/ui/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  const DocApp({super.key, });

  @override
  Widget build(BuildContext context) {
    int doctorId = 1;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: false,
        theme: ThemeData(
          primaryColor: MyColors.myBlue,
          scaffoldBackgroundColor: MyColors.myWhite,
        ),
        home: OnboardingScreen(),
      ),
    );
  }
}
