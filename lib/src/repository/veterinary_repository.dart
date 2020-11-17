import '../model/veterinary_model.dart';
import 'veterinary_Api_Service.dart';

class VeterinaryRepository {
  final veterinaryApiService = VeterinaryApiService();

  Future<Veterinary> saveVeterinary(Veterinary veterinary) =>
      veterinaryApiService.saveVeterinary(veterinary);
  Future<Veterinary> updateVeterinary(Veterinary veterinary) =>
      veterinaryApiService.updateVeterinary(veterinary);
  Future<List<Veterinary>> findAllVeterinary() =>
      veterinaryApiService.findAllVeterinary();
}
