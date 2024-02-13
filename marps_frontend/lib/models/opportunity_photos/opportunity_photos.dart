import 'dart:convert';

import 'camera.dart';
import 'rover.dart';

class OpportunityPhotos {
  List<Photo>? photos;

  OpportunityPhotos({this.photos});

  factory OpportunityPhotos.fromMap(Map<String, dynamic> data) {
    return OpportunityPhotos(
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
  /// Parses the string and returns the resulting Json object as [OpportunityPhotos].
  factory OpportunityPhotos.fromJson(String data) {
    return OpportunityPhotos.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OpportunityPhotos] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Photo {
  int? id;
  int? sol;
  Camera? camera;
  String? imgSrc;
  String? earthDate;
  Rover? rover;

  Photo({
    this.id,
    this.sol,
    this.camera,
    this.imgSrc,
    this.earthDate,
    this.rover,
  });

  factory Photo.fromMap(Map<String, dynamic> data) => Photo(
        id: data['id'] as int?,
        sol: data['sol'] as int?,
        camera: data['camera'] == null
            ? null
            : Camera.fromMap(data['camera'] as Map<String, dynamic>),
        imgSrc: data['img_src'] as String?,
        earthDate: data['earth_date'] as String?,
        rover: data['rover'] == null
            ? null
            : Rover.fromMap(data['rover'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'sol': sol,
        'camera': camera?.toMap(),
        'img_src': imgSrc,
        'earth_date': earthDate,
        'rover': rover?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Photo].
  factory Photo.fromJson(String data) {
    return Photo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Photo] to a JSON string.
  String toJson() => json.encode(toMap());
}
