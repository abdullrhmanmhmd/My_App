import 'package:docdoc/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorImageAndName extends StatelessWidget {
  const DoctorImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            "assets/images/doctor2.png",
            height: 80.h,
            width: 80.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "Dr. Randy Wigham",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.myBlack,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),

              child: Text(
                'Specialization | Degree',
                style: TextStyle(
                  color: MyColors.myGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: MyColors.myGrey,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Doctor City, Governrate',
                  style: TextStyle(
                    color: MyColors.myGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: SvgPicture.asset(
            "assets/svgs/message.svg",
            height: 25.h,
            width: 25.w,
          ),
        ),
      ],
    );
  }
}
