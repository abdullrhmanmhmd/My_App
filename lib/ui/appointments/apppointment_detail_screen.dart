import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/models/all_appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final AllAppointmentModel appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doc = appointment.doctor;
    final pat = appointment.patient;

    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.myWhite,
        surfaceTintColor: Colors.transparent,

        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColors.myBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Appointment Details',
          style: TextStyle(
            color: MyColors.myBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Section
            Text(
              'Doctor',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    doc?.name ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.myBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Specialty',
                    style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    doc?.specialization?.name ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.myBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Appointment Section
            Text(
              'Appointment',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date & Time',
                    style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    appointment.appointmentTime ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.myBlack,
                    ),
                  ),
                  if (appointment.appointmentEndTime != null) ...[
                    SizedBox(height: 12.h),
                    Text(
                      'End Time',
                      style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      appointment.appointmentEndTime ?? 'N/A',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                  ],
                  if (appointment.appointmentPrice != null) ...[
                    SizedBox(height: 12.h),
                    Text(
                      'Price',
                      style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${appointment.appointmentPrice} EGP',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Patient Section
            if (pat != null) ...[
              Text(
                'Patient',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myBlue,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 12.sp, color: MyColors.myGrey),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      pat.name ?? 'N/A',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.myBlack,
                      ),
                    ),
                    if (pat.email != null) ...[
                      SizedBox(height: 12.h),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: MyColors.myGrey,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        pat.email!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: MyColors.myBlack,
                        ),
                      ),
                    ],
                    if (pat.phone != null) ...[
                      SizedBox(height: 12.h),
                      Text(
                        'Phone',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: MyColors.myGrey,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        pat.phone!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: MyColors.myBlack,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],

            // Notes Section
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myBlue,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Text(
                  appointment.notes!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: MyColors.myBlack,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
