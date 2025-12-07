import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_bloc.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_event.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_state.dart';
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
                      padding: const EdgeInsets.only(bottom:110.0),
                      child: Text("No appointments found",style:TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: MyColors.myGrey,

                      )),
                    ),

                  );
                }

                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appt = appointments[index];

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      margin: EdgeInsets.only(bottom: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFF7F7F7),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 16.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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

                                SizedBox(height: 4.h),

                                Text(
                                  "Status: ${appt.status ?? "N/A"}",
                                  style: TextStyle(
                                    color: MyColors.myGrey,
                                    fontSize: 13.sp,
                                  ),
                                ),

                                SizedBox(height: 4.h),
                                Text(
                                  "Notes: ${appt.notes ?? "N/A"}",

                                  style: TextStyle(
                                    color: MyColors.myGrey,
                                    fontSize: 13.sp,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
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
