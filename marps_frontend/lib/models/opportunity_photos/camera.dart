import 'dart:convert';

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
