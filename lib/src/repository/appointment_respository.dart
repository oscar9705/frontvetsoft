import 'package:demo/src/model/appointment_model.dart';
import 'package:demo/src/repository/appointment_Api_Service.dart';
import 'package:demo/src/utility/ApiResponse.dart';

AppointmentApiService appointmentApiService;

class AppointmentRespository {
  Future<ApiResponse> getAllAppointments(Appointment appointment) =>
      appointmentApiService.getAllAppointments();
  Future<ApiResponse> insertAppointment(Appointment appointment) =>
      appointmentApiService.insertAppointment(appointment);
}
