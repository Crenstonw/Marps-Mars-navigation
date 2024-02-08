import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/photo.dart';

abstract class CuriosityRepository {
  Future<List<Photo>> fetchPhotos();
}
