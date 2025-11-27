import 'package:docdoc/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorBlueContainer extends StatelessWidget {
  const DoctorBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 165.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage("assets/images/home_pattern.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book and\nschedule with\nnearest doctor",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.myWhite,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.myWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(47),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Find Nearby",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: MyColors.myBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 0,

            child: Image.asset("assets/images/home_doctor.png", height: 200.h),
          ),
        ],
      ),
    );
  }
}
