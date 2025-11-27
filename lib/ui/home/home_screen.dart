import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_bloc.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_event.dart';
import 'package:docdoc/logic/auth/auth_repo.dart';
import 'package:docdoc/logic/home/home_bloc.dart';
import 'package:docdoc/logic/home/home_event.dart';
import 'package:docdoc/logic/home/home_state.dart';
import 'package:docdoc/logic/models/user_model.dart';
import 'package:docdoc/ui/all_doctors/all_doctors_screen.dart';
import 'package:docdoc/ui/doctor_details/doctor_details_screen.dart';
import 'package:docdoc/ui/home/widgets/doctor_blue_container.dart';
import 'package:docdoc/ui/home/widgets/doctor_specialty_list_view.dart';
import 'package:docdoc/ui/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userModel});
  final UserModel? userModel;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  UserModel? userModel;
  int? selectedCityId;

  final AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfile();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String? error;
      if (e is ApiError) error = e.massage;
      ScaffoldMessenger.of(context).showSnackBar(customSnack(error ?? 'Error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchHomeData()),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0, top:16.0, right:20.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi,${userModel?.name ?? 'Loading..'}!",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.myDarkBlue,
                          ),
                        ),
                        // SizedBox(height: 5.h),
                        Text(
                          "How Are You Today?",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myGrey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: MyColors.moreLightGrey,
                      child: SvgPicture.asset("assets/svgs/notification.svg"),
                    ),
                  ],
                ),
                DoctorBlueContainer(),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Text(
                      "Doctor Speciality",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: MyColors.myBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                DoctorSpecialityListView(),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Text(
                      "Recommendation Doctor",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  AllDoctorsBloc()..add(FetchAllDoctors(
                                      selectedCityId
                                  )),
                              child: const AllDoctorsScreen(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.myBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Expanded(
                  child: BlocBuilder<
                      HomeBloc,
                      HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.myBlue,
                          ),
                        );
                      } else if (state is HomeSuccess) {
                        final doctors = state.doctors;
                        return ListView.builder(
                          itemCount: doctors.length,
                          scrollDirection: Axis.vertical,

                          itemBuilder: (context, int index) {
                            final doctor = doctors[index];
                            return GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(

                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetailsScreen(doctor: doctor,),
                                    ),

                                  );

                                },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xFFF7F7F7),

                                ),
                                child: Row(
                                  children: [
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(12),
                                    //   child: Image.asset(
                                    //     doctor.photo.toString() ??
                                    //         "assets/images/doctor.jpg",
                                    //     height: 120.h,
                                    //     width: 120.w,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                            );
                          },
                        );
                      } else if (state is HomeError) {
                        return Center(
                          child: Text(
                            "Error: ${state.massage}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("Failed to load doctors"),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
