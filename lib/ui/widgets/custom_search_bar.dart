import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:docdoc/core/constants/my_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({super.key,required this.controller});

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {


    return Row(
      children: [
        // Search bar container
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: MyColors.myLightGrey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                SvgPicture.asset("assets/svgs/search-normal.svg"),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(

                        color: MyColors.myGrey.withOpacity(0.5),
                        fontSize: 16.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Filter icon on the right
        Icon(
          Icons.filter_list_rounded,
          color: MyColors.myBlack,
          size: 30.sp,
        ),
      ],
    );
  }
}
