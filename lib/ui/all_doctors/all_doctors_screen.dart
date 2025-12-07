import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_bloc.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_event.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_state.dart';
import 'package:docdoc/logic/city/city_bloc.dart';
import 'package:docdoc/logic/city/city_event.dart';
import 'package:docdoc/logic/city/city_state.dart';
import 'package:docdoc/logic/models/city_model.dart';
import 'package:docdoc/ui/doctor_details/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  int? selectedCityId;
   CityModel? cityModel;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CityBloc()..add(FetchCitiesEvent())),
        BlocProvider(create: (_) => AllDoctorsBloc()..add(FetchAllDoctors(selectedCityId))),
      ],
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,

          backgroundColor: MyColors.myWhite,
          automaticallyImplyLeading: false,
          leadingWidth: 72.w,
          title: Text(
            "All Doctors",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: MyColors.myBlack,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 9.w),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: MyColors.myBlack,
                size: 20.sp,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: MyColors.myLightGrey, width: 1.w),
                ),
                child: Icon(
                  Icons.more_horiz,
                  color: MyColors.myBlack,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,


          margin: EdgeInsets.only(left: 18.w, top: 25.h, right: 18.w),
          child: Column(
            children: [
              BlocBuilder<CityBloc, CityState>(
                builder: (context, state) {
                  if (state is CityLoading) {
                    return SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator(
                        color: MyColors.myBlue,

                      )),
                    );
                  }

                  if (state is CityLoaded) {
                    print("Cities Loaded: ${state.cities.length}");
                    final cities = state.cities;

                    return SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          final isSelected = city.id == selectedCityId;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCityId = city.id;
                              });
                              context.read<AllDoctorsBloc>().add(
                                FetchAllDoctors(
                                 selectedCityId,
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w),
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: isSelected ? MyColors.myBlue : MyColors.myLightGrey,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: Text(
                                  city.name,
                                  style: TextStyle(
                                    color: isSelected ? MyColors.myWhite : MyColors.myBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );


                  }
                  else if (state is CityError) {
                    return Center(
                      child: Text(
                        "Error: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text("Failed to load doctors"));
                  }
                },
              ),

              SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<AllDoctorsBloc, AllDoctorsState>(
                  builder: (context, state) {
                    if (state is AllDoctorsLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: MyColors.myBlue),
                      );
                    } else if (state is AllDoctorsSuccess) {
                      final doctors = state.doctors;
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
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor.name ?? "Unknown Doctor",
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
                                              doctor.email ?? "No email available",
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
                    } else if (state is AllDoctorsError) {
                      return Center(
                        child: Text(
                          "Error: ${state.massage}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const Center(child: Text("Failed to load doctors"));
                    }
                  },
                ),
              ),
            ],
          )

        ),
      ),
    );
  }
}
