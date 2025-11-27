import 'package:docdoc/logic/models/all_appointment_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllAppointmentState extends Equatable {
  const AllAppointmentState();

  @override
  List<Object?> get props => [];
}

class AllAppointmentInitial extends AllAppointmentState {}
class AllAppointmentLoading extends AllAppointmentState {}
class AllAppointmentSuccess extends AllAppointmentState {
  final List <AllAppointmentModel> appointments;

  const AllAppointmentSuccess(this.appointments);
  @override
  List<Object?> get props => [appointments];
}
class AllAppointmentError extends AllAppointmentState {
  final String massage;

  const AllAppointmentError(this.massage);

  @override
  List<Object?> get props => [massage];
}
