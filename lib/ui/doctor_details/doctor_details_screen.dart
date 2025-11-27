import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_services.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_bloc.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_repo.dart';
import 'package:docdoc/logic/models/doctor_model.dart';
import 'package:docdoc/ui/doctor_details/widgets/doctor_image_and_name.dart';
import 'package:docdoc/ui/screens/add_appointmemt_screen.dart';
// import 'package:docdoc/ui/doctor_details/widgets/phone_email_address.dart';
import 'package:docdoc/ui/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: MyColors.myWhite,
        automaticallyImplyLeading: false,
        leadingWidth: 72.w,
        title: Text(
          "Doctor Details",
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
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12.r),
              //   child: Image.asset(
              //     doctor.photo.toString(),
              //     height: 80.h,
              //     width: 80.w,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      doctor.name ?? "Unknown Doctor",
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
                      '${doctor.specialization?.name ?? "N/A"}| ${doctor.degree ?? "N/A"}',
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
                        '${doctor.city?.name ?? "Unknown City"}, ${doctor.city?.governrate?.name ?? "Unknown Governorate"}',
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
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
              SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: MyColors.myBlue,
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        doctor.phone ?? 'doctor phone',
                        style: TextStyle(
                          color: MyColors.myBlack.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: MyColors.myBlue,
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        doctor.email ?? 'doctor email',
                        style: TextStyle(
                          color: MyColors.myBlack.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: MyColors.myBlue,
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        doctor.address ?? 'doctor address',
                        style: TextStyle(
                          color: MyColors.myBlack.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
              SizedBox(height: 40.h),
              Text(
                "About Doctor",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: MyColors.myBlack,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                doctor.description ?? 'doctor description',
                style: TextStyle(
                  color: MyColors.myGrey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointment Price",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myGrey,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      doctor.appointPrice.toString() ?? 'doctor price',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "Available Time",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myGrey,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${doctor.startTime.toString()} : ${doctor.endTime.toString()}" ?? 'doctor start time',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              AppTextButton(
                buttonText: "Book Appointment",
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: MyColors.myWhite,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<AppointmentBloc>(
                        create: (context) => AppointmentBloc(
                          AppointmentRepo(ApiServices()),  // Inject your repo and API service here
                        ),
                        child: AddAppointmentScreen(
                          doctorId: widget.doctor.id!,  // Ensure doctor.id is not null (add null check if needed)
                        ),
                      ),
                    ),
                  );
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
