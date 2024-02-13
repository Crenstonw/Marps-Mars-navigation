import 'dart:convert';

import 'photo.dart';

class CameraDetailResponse {
  List<Photo>? photos;

  CameraDetailResponse({this.photos});

  factory CameraDetailResponse.fromMap(Map<String, dynamic> data) {
    return CameraDetailResponse(
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
  /// Parses the string and returns the resulting Json object as [CameraDetailResponse].
  factory CameraDetailResponse.fromJson(String data) {
    return CameraDetailResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CameraDetailResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
