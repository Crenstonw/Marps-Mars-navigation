import 'dart:async';

import 'package:http/http.dart';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_detail_repository.dart';

class OpportunityDetailRepositoryImpl extends OpportunityDetailRepository {
  final Client _httpClient = Client();

  @override
  Future<List<Camera>> fetchOpportunityCameras() async {
    final response = await _httpClient.get(Uri.parse(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity&api_key=bGoSRAIf9LDH1fFOuHFcx7OXOqKGnqCFrPgA2wlK'));
    if (response.statusCode == 200) {
      return Rover.fromJson(response.body).cameras!;
    } else {
      throw Exception('Failed to load the cameras');
    }
  }
}