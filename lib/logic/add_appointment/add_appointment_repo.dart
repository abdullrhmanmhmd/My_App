import 'package:docdoc/core/network/api_services.dart';
import 'package:docdoc/logic/models/add_appointment_model.dart';


class AppointmentRepo {
  final ApiServices api;

  AppointmentRepo(this.api);

  Future<dynamic> storeAppointment(AddAppointment request) async {
    return await api.post("appointment/store", request.toJson());
  }
}
