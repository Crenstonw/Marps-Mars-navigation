import 'dart:async';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';

abstract class OpportunityRepository {
  Future<List<Photo>> fetchOpportunityPhotos(int sol);

  Future<List<Camera>> fetchOpportunityCameras();
}
