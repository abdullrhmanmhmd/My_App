class AddAppointment {
  final int doctorId;
  final String startTime;
  final String notes;

  AddAppointment({
    required this.doctorId,
    required this.startTime,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'start_time': startTime,
      'notes': notes,
    };
  }
}
