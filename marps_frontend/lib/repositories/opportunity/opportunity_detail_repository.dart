import 'dart:async';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';

abstract class OpportunityDetailRepository {
  Future<List<Camera>> fetchOpportunityCameras();
}