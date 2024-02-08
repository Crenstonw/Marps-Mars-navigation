import 'dart:convert';

import 'photo.dart';

class MarsPhotosCuriosityResponse {
  List<Photo>? photos;

  MarsPhotosCuriosityResponse({this.photos});

  factory MarsPhotosCuriosityResponse.fromMap(Map<String, dynamic> data) {
    return MarsPhotosCuriosityResponse(
      photos: (data['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'photos': photos?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MarsPhotosCuriosityResponse].
  factory MarsPhotosCuriosityResponse.fromJson(String data) {
    return MarsPhotosCuriosityResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MarsPhotosCuriosityResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
