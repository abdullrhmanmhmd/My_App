import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_bloc.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_event.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_state.dart';
import 'package:docdoc/logic/models/add_appointment_model.dart';
import 'package:docdoc/ui/widgets/app_text_button.dart';
import 'package:docdoc/ui/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAppointmentScreen extends StatefulWidget {
  final int doctorId;

  const AddAppointmentScreen({super.key, required this.doctorId});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  late TextEditingController startTimeController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    startTimeController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    startTimeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: MyColors.myWhite,
        automaticallyImplyLeading: false,
        leadingWidth: 72.w,
        title: Text(
          "Book Appointment",
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
      body: BlocListener<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(
                'Appointment booked successfully',
                backgroundColor: Colors.green,
                icon: Icons.check_circle,
              ),
            );
            Navigator.pop(context);
          }

          if (state is AppointmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // DATE PICKER
              GestureDetector(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: MyColors.myBlue, // Header & selected color
                            onPrimary: Colors.white, // Text on header
                            onSurface: MyColors.myBlue, // Body text
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: MyColors.myBlue,
                              onPrimary: Colors.white,
                              onSurface: MyColors.myBlue,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedTime != null) {
                      final combined = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      startTimeController.text = combined.toString().substring(
                        0,
                        16,
                      );
                    }
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: startTimeController,
                    decoration: InputDecoration(
                      labelText: "Start Time (YYYY-MM-DD HH:mm)",

                      labelStyle: const TextStyle(color: Colors.grey),

                      floatingLabelStyle: TextStyle(
                        color: MyColors.myBlue,
                        fontWeight: FontWeight.w600,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColors.myBlue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              SizedBox(height: 16.h),

              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Notes",

                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),

                  floatingLabelStyle: TextStyle(
                    color: MyColors.myBlue,
                    fontWeight: FontWeight.w600,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.myBlue, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              BlocBuilder<AppointmentBloc, AppointmentState>(
                builder: (context, state) {
                  bool isLoading = state is AppointmentLoading;
                  return isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyColors.myBlue,
                            strokeWidth: 2,
                            backgroundColor: MyColors.myWhite,
                          ),
                        )
                      : AppTextButton(
                          buttonText: "Submit",
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: MyColors.myWhite,
                          ),
                          onPressed: () {
                            if (startTimeController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnack('Please select a start time'),
                              );
                              return;
                            }
                            final request = AddAppointment(
                              doctorId: widget.doctorId,
                              startTime: startTimeController.text.trim(),
                              notes: notesController.text.trim(),
                            );
                            context.read<AppointmentBloc>().add(
                              StoreAppointmentEvent(request),
                            );
                          },
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
