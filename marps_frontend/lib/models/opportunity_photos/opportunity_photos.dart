import 'dart:convert';

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

class Rover {
  int? id;
  String? name;
  String? landingDate;
  String? launchDate;
  String? status;
  int? maxSol;
  String? maxDate;
  int? totalPhotos;
  List<Camera>? cameras;

  Rover({
    this.id,
    this.name,
    this.landingDate,
    this.launchDate,
    this.status,
    this.maxSol,
    this.maxDate,
    this.totalPhotos,
    this.cameras,
  });

  factory Rover.fromMap(Map<String, dynamic> data) => Rover(
        id: data['id'] as int?,
        name: data['name'] as String?,
        landingDate: data['landing_date'] as String?,
        launchDate: data['launch_date'] as String?,
        status: data['status'] as String?,
        maxSol: data['max_sol'] as int?,
        maxDate: data['max_date'] as String?,
        totalPhotos: data['total_photos'] as int?,
        cameras: (data['cameras'] as List<dynamic>?)
            ?.map((e) => Camera.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'landing_date': landingDate,
        'launch_date': launchDate,
        'status': status,
        'max_sol': maxSol,
        'max_date': maxDate,
        'total_photos': totalPhotos,
        'cameras': cameras?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rover].
  factory Rover.fromJson(String data) {
    return Rover.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rover] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Camera {
  int? id;
  String? name;
  int? roverId;
  String? fullName;

  Camera({this.id, this.name, this.roverId, this.fullName});

  factory Camera.fromMap(Map<String, dynamic> data) => Camera(
        id: data['id'] as int?,
        name: data['name'] as String?,
        roverId: data['rover_id'] as int?,
        fullName: data['full_name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'rover_id': roverId,
        'full_name': fullName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Camera].
  factory Camera.fromJson(String data) {
    return Camera.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Camera] to a JSON string.
  String toJson() => json.encode(toMap());
}
