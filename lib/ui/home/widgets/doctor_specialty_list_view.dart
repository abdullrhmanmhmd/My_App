import 'package:docdoc/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorSpecialityListView extends StatelessWidget {
  const DoctorSpecialityListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> specialityList = [
      "General",
      "Neurologic",
      "Pediatric",
      "Radiology",
      "Neurologic",
      "Neurologic",
      "Neurologic",
      "Neurologic",
    ];
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {



          return Padding(
            padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 24.w),
            child: Column(
              children: [
                CircleAvatar(

                  radius: 30.r,
                  backgroundColor: Color.fromRGBO(244, 248, 255, 1),
                  child: SvgPicture.asset("assets/svgs/doctor_speciality.svg"),
                ),
                SizedBox(height: 8.h,),
                Text(specialityList[index],style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.myBlack

                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
