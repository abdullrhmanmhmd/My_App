import 'package:docdoc/logic/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllDoctorsState extends Equatable {
  const AllDoctorsState();

  @override
  List<Object?> get props => [];
}

class AllDoctorsInitial extends AllDoctorsState {}
class AllDoctorsLoading extends AllDoctorsState {}
class AllDoctorsSuccess extends AllDoctorsState {
  final List <DoctorModel> doctors;

  const AllDoctorsSuccess(this.doctors);
  @override
  List<Object?> get props => [doctors];
}
class AllDoctorsError extends AllDoctorsState {
  final String massage;

  const AllDoctorsError(this.massage);

  @override
  List<Object?> get props => [massage];
}
