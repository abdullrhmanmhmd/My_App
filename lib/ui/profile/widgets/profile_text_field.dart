import 'package:docdoc/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({super.key, required this.labelHint,required this.controller});

  final String labelHint;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: MyColors.myBlue.withOpacity(0.3), // highlight color
        selectionHandleColor: MyColors.myBlue, // handle color
        cursorColor: MyColors.myBlue, // optional, for consistency
      ),
      child: TextField(
        controller: controller ,
        cursorColor: MyColors.myBlue,
        cursorWidth: 2.w,
        cursorRadius: Radius.circular(6.r),
        decoration: InputDecoration(
          labelText: labelHint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: MyColors.myWhite,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 1.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: BorderSide(
              color: const Color.fromRGBO(237, 237, 237, 1),
              width: 1.1.sp,
            ),
          ),
        ),
      ),
    );
  }
}
