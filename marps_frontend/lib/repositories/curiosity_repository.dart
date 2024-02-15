import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';

abstract class CuriosityRepository {
  Future<List<Photo>> fetchPhotos();
}
