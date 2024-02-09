import 'dart:convert';

import 'photo.dart';

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
