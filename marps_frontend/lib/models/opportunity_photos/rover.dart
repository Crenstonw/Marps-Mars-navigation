import 'dart:convert';

import 'camera.dart';

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
