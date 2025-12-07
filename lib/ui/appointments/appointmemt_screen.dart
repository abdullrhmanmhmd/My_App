import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_bloc.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_event.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_state.dart';
import 'package:docdoc/ui/appointments/apppointment_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmemtScreen extends StatelessWidget {
  const AppointmemtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllAppointmentBloc()..add(FetchAllAppointment()),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        appBar: AppBar(
          backgroundColor: MyColors.myWhite,
          surfaceTintColor: Colors.transparent,
          title: Text(
            "Appointments",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: MyColors.myBlack,
            ),
          ),
          centerTitle: true,
          leading: SizedBox.shrink(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: BlocBuilder<AllAppointmentBloc, AllAppointmentState>(
            builder: (context, state) {
              if (state is AllAppointmentLoading) {
                return Center(
                  child: CircularProgressIndicator(color: MyColors.myBlue),
                );
              }

              if (state is AllAppointmentError) {
                return Center(
                  child: Text(
                    "Error: ${state.massage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is AllAppointmentSuccess) {
                final appointments = state.appointments;

                if (appointments.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 110.0),
                      child: Text(
                        "No appointments found",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: MyColors.myGrey,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appt = appointments[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AppointmentDetailsScreen(appointment: appt),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  CircleAvatar(
                                    radius: 35.r,
                                    backgroundColor: MyColors.myBlue
                                        .withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      size: 35.sp,
                                      color: MyColors.myBlue,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appt.doctor?.name ?? "Unknown Doctor",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: MyColors.myBlack,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          appt.doctor?.specialization?.name ??
                                              "No Specialization",
                                          style: TextStyle(
                                            color: MyColors.myGrey,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          "Time: ${appt.appointmentTime ?? "--"}",
                                          style: TextStyle(
                                            color: MyColors.myBlack,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        if (appt.notes != null &&
                                            appt.notes!.isNotEmpty) ...[
                                          SizedBox(height: 4.h),
                                          Text(
                                            "Notes: ${appt.notes}",
                                            style: TextStyle(
                                              color: MyColors.myGrey,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
