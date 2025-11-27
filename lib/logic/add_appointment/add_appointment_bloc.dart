import 'package:docdoc/logic/add_appointment/add_appointment_event.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_repo.dart';
import 'package:docdoc/logic/add_appointment/add_appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo repo;

  AppointmentBloc(this.repo) : super(AppointmentInitial()) {
    on<StoreAppointmentEvent>((event, emit) async {
      emit(AppointmentLoading());

      try {
        final data = await repo.storeAppointment(event.request);
        emit(AppointmentSuccess(data));
      } catch (e) {
        emit(AppointmentError(e.toString()));
      }
    });
  }
}
