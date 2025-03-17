import 'dart:convert';

class IngredientModel {
  int? id;
  String? image;
  String? name;

  IngredientModel({
    this.id,
    this.image,
    this.name,
  });

  IngredientModel copyWith({
    int? id,
    String? image,
    String? name,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'] != null ? map['id'] as int : null,
      image: map['image'] != null
          ? "https://spoonacular.com/cdn/ingredients_100x100/${map['image']}"
          : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromJson(String source) =>
      IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IngredientModel(id: $id, image: $image, name: $name)';

  @override
  bool operator ==(covariant IngredientModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.image == image && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode ^ name.hashCode;
}
