import 'package:marps_frontend/models/curiosity/camera_detail_response/photo.dart';

abstract class CameraDetailRepository {
  Future<List<Photo>> fetchPhotos();
}
