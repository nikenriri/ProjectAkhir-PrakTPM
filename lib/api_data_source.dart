import 'package:projectakhir_praktpm/model/detail_model.dart';
import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCharacter() {
    return BaseNetwork.get("character");
  }

  Future<DetailModel> loadDetailCharacter(int idDiterima) async {
    String id = idDiterima.toString();
    final response = await BaseNetwork.get("character/$id");
    if (response.containsKey('id')) {
      dynamic character = response;
      DetailModel characterDetail = DetailModel.fromJson(character);
      return characterDetail;
    } else {
      throw Exception("Failed to load character");
    }
  }
}
