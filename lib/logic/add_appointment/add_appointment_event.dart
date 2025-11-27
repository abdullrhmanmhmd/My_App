import 'package:docdoc/logic/models/add_appointment_model.dart';

abstract class AppointmentEvent {}

class StoreAppointmentEvent extends AppointmentEvent {
  final AddAppointment request;
  StoreAppointmentEvent(this.request);
}
