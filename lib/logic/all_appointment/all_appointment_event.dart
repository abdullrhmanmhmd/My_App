import 'package:equatable/equatable.dart';

abstract class AllAppointmentEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchAllAppointment extends AllAppointmentEvent{}