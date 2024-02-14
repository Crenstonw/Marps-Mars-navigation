import 'dart:convert';

import 'package:http/http.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/camera_detail_repository.dart';

class CameraDetailRepositoryImpl extends CameraDetailRepository {
  final Client _client = Client();

  //porque coño si le paso el name a esta peticion despues da error en el bloc
  @override
  Future<List<Photo>> fetchDetails(String name) async {
    final response = await _client.get(Uri.parse(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=$name&api_key=bGoSRAIf9LDH1fFOuHFcx7OXOqKGnqCFrPgA2wlK'));
    if (response.statusCode == 200) {
      return MarsPhotosCuriosityResponse.fromJson(json.decode(response.body))
          .photos!;
    } else {
      throw Exception('Fail to load photos');
    }
  }
}
