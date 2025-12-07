import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_bloc.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_event.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_state.dart';
import 'package:docdoc/logic/models/add_appointment_model.dart';
import 'package:docdoc/ui/appointments/appointment_confirmation.dart';
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
  String? _selectedTime;

  final List<String> _availableTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    startTimeController = TextEditingController();
    notesController = TextEditingController();
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
            final appointment = AddAppointment(
              doctorId: widget.doctorId,
              startTime: startTimeController.text.trim(),
              notes: notesController.text.trim(),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentConfirmationScreen(
                  appointment: appointment,
                ),
              ),
            );
          }

          if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(
                state.message,
                backgroundColor: Colors.red,
                icon: Icons.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

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
                              primary: MyColors.myBlue,
                              onPrimary: Colors.white,
                              onSurface: MyColors.myBlue,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      setState(() {
                        startTimeController.text =
                        '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: startTimeController,
                      decoration: InputDecoration(
                        labelText: "Select Date (YYYY-MM-DD)",
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
                SizedBox(height: 20.h),
                Text(
                  'Select Time',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 7.w,
                  runSpacing: 12.h,
                  children: _availableTimes.map((time) {
                    final isSelected = _selectedTime == time;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? MyColors.myBlue
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? MyColors.myBlue
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color:
                            isSelected ? Colors.white : MyColors.myGrey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h),

                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Additional Notes (Optional)",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
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
                      borderSide: BorderSide(
                        color: MyColors.myBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),

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
                            customSnack('Please select a date'),
                          );
                          return;
                        }
                        if (_selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnack('Please select a time'),
                          );
                          return;
                        }

                        final dateTimeString =
                            '${startTimeController.text} ${_selectedTime!}';

                        final request = AddAppointment(
                          doctorId: widget.doctorId,
                          startTime: dateTimeString,
                          notes: notesController.text.trim(),
                        );
                        context.read<AppointmentBloc>().add(
                          StoreAppointmentEvent(request),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}