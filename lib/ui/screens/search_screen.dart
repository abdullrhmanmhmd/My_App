import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/serach/search_bloc.dart';
import 'package:docdoc/logic/serach/search_event.dart';
import 'package:docdoc/logic/serach/search_state.dart';
import 'package:docdoc/ui/doctor_details/doctor_details_screen.dart';
import 'package:docdoc/ui/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),

      child: Builder(
        builder: (context) {
          final TextEditingController searchController =
              TextEditingController();
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,

              backgroundColor: MyColors.myWhite,
              automaticallyImplyLeading: false,
              leadingWidth: 72.w,
              title: Text(
                "Search",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: MyColors.myBlack,
                ),
              ),
              centerTitle: true,
              leading: SizedBox.shrink(),
            ),

            body: Container(
              width: double.infinity,

              margin: EdgeInsets.only(left: 18.w, top: 25.h, right: 18.w),
              child: Column(
                children: [
                  Row(
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
                                  onChanged: (value) {
                                    BlocProvider.of<SearchBloc>(
                                      context,
                                    ).add(SearchDoctorsEvent(value));
                                  },
                                  controller: searchController,
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
                  ),
                  SizedBox(height: 25.h),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: MyColors.myBlue,
                            ),
                          );
                        } else if (state is SearchLoaded) {
                          final doctors = state.results;
                          if (doctors.isEmpty) {
                            return Center(
                              child: Text(
                                "No doctors found",
                                style: TextStyle(fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.myGrey,
                                ),

                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: doctors.length,
                            itemBuilder: (context, int index) {
                              final doctor = doctors[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DoctorDetailsScreen(doctor: doctor),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 126.h,
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color(0xFFF7F7F7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.circular(12),
                                        //   child: Image.network(
                                        //     doctor.photo.toString() ?? "https://via.placeholder.com/150",
                                        //     height: 110.h,
                                        //     width: 110.w,
                                        //     fit: BoxFit.cover,

                                        //   ),
                                        // ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 25,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doctor.name ??
                                                      "Unknown Doctor",
                                                  style: TextStyle(
                                                    color: MyColors.myBlack,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  '${doctor.degree ?? "N/A"} | ${doctor.phone ?? "N/A"}',
                                                  style: TextStyle(
                                                    color: MyColors.myGrey,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  doctor.email ??
                                                      "No email available",
                                                  style: TextStyle(
                                                    color: MyColors.myGrey,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is SearchError) {
                          return Center(
                            child: Text(
                              "Error: ${state.message}",
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:140.0),
                              child: Text("Search for a doctor",style:TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: MyColors.myGrey,

                              )),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
