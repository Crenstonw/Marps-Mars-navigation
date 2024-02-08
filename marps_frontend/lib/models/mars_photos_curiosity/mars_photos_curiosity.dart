import 'dart:convert';

import 'photo.dart';

class MarsPhotosCuriosity {
  List<Photo>? photos;

  MarsPhotosCuriosity({this.photos});

  factory MarsPhotosCuriosity.fromMap(Map<String, dynamic> data) {
    return MarsPhotosCuriosity(
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
  /// Parses the string and returns the resulting Json object as [MarsPhotosCuriosity].
  factory MarsPhotosCuriosity.fromJson(String data) {
    return MarsPhotosCuriosity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MarsPhotosCuriosity] to a JSON string.
  String toJson() => json.encode(toMap());
}
