import 'dart:convert';
import 'package:http/http.dart';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_repository.dart';

class OpportunityRepositoryImpl extends OpportunityRepository {
  final Client _httpClient = Client();

  @override
  Future<List<Photo>> fetchOpportunityPhotos(int sol) async {
    final response = await _httpClient.get(Uri.parse(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?$sol&api_key=bGoSRAIf9LDH1fFOuHFcx7OXOqKGnqCFrPgA2wlK'));
    if (response.statusCode == 200) {
      return OpportunityPhotos.fromJson(json.decode(response.body)).photos!;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
