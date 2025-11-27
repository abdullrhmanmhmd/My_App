import 'package:docdoc/logic/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final List <DoctorModel> doctors;

  const HomeSuccess(this.doctors);
  @override
  List<Object?> get props => [doctors];
}
class HomeError extends HomeState {
  final String massage;

  const HomeError(this.massage);

  @override
  List<Object?> get props => [massage];
}
