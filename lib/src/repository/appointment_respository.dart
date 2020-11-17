import 'package:demo/src/model/appointment_model.dart';
import 'package:demo/src/repository/appointment_Api_Service.dart';
import 'package:demo/src/utility/ApiResponse.dart';

AppointmentApiService appointmentApiService;

class AppointmentRespository {
  Future<ApiResponse> getAllAppointments() =>
      appointmentApiService.getAllAppointments();
  Future<ApiResponse> getAppointmentById(String id) =>
      appointmentApiService.getAppointmentById(id);
  Future<ApiResponse> insertAppointment(Appointment appointment) =>
      appointmentApiService.insertAppointment(appointment);
  Future<ApiResponse> updateAppointment(Appointment appointment) =>
      appointmentApiService.updateAppointment(appointment);
  Future<ApiResponse> deleteAppointmentById(String id) =>
      appointmentApiService.deleteAppointmentById(id);
}
