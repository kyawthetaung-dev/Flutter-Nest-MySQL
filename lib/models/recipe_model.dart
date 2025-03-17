import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'ingredient_model.dart';

class RecipeModel {
  int? id;
  String? title;
  String? image;
  String? imageType;
  int? servings;
  int? readyInMinutes;
  int? cookingMinutes;
  int? preparationMinutes;
  List<dynamic>? analyzedInstructions;
  String? instructions;
  List<IngredientModel>? extendedIngredients;
  String? mealPlanDate;

  RecipeModel({
    this.id,
    this.title,
    this.image,
    this.imageType,
    this.servings,
    this.readyInMinutes,
    this.cookingMinutes,
    this.preparationMinutes,
    this.analyzedInstructions,
    this.instructions,
    this.extendedIngredients,
    this.mealPlanDate,
  });

  RecipeModel copyWith({
    int? id,
    String? title,
    String? image,
    String? imageType,
    int? servings,
    int? readyInMinutes,
    int? cookingMinutes,
    int? preparationMinutes,
    List<dynamic>? analyzedInstructions,
    String? instructions,
    List<IngredientModel>? extendedIngredients,
    String? mealPlanDate,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      imageType: imageType ?? this.imageType,
      servings: servings ?? this.servings,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      cookingMinutes: cookingMinutes ?? this.cookingMinutes,
      preparationMinutes: preparationMinutes ?? this.preparationMinutes,
      analyzedInstructions: analyzedInstructions ?? this.analyzedInstructions,
      instructions: instructions ?? this.instructions,
      extendedIngredients: extendedIngredients ?? this.extendedIngredients,
      mealPlanDate: mealPlanDate ?? this.mealPlanDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'imageType': imageType,
      'servings': servings,
      'readyInMinutes': readyInMinutes,
      'cookingMinutes': cookingMinutes,
      'preparationMinutes': preparationMinutes,
      'analyzedInstructions': analyzedInstructions,
      'instructions': instructions,
      'extendedIngredients':
          extendedIngredients?.map((x) => x.toMap()).toList(),
      'mealPlanDate': mealPlanDate,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      imageType: map['imageType'] != null ? map['imageType'] as String : null,
      servings: map['servings'] != null ? map['servings'] as int : null,
      readyInMinutes:
          map['readyInMinutes'] != null ? map['readyInMinutes'] as int : null,
      cookingMinutes:
          map['cookingMinutes'] != null ? map['cookingMinutes'] as int : null,
      preparationMinutes: map['preparationMinutes'] != null
          ? map['preparationMinutes'] as int
          : null,
      analyzedInstructions: map['analyzedInstructions'] != null
          ? List<dynamic>.from((map['analyzedInstructions'] as List<dynamic>))
          : null,
      instructions:
          map['instructions'] != null ? map['instructions'] as String : null,
      extendedIngredients: map['extendedIngredients'] != null
          ? List<IngredientModel>.from(
              (map['extendedIngredients'] as List<dynamic>)
                  .map<IngredientModel?>(
                (x) => IngredientModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      mealPlanDate:
          map['mealPlanDate'] != null ? map['mealPlanDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) =>
      RecipeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecipeModel(id: $id, title: $title, image: $image, imageType: $imageType, servings: $servings, readyInMinutes: $readyInMinutes, cookingMinutes: $cookingMinutes, preparationMinutes: $preparationMinutes, analyzedInstructions: $analyzedInstructions, instructions: $instructions, extendedIngredients: $extendedIngredients, mealPlanDate: $mealPlanDate)';
  }

  @override
  bool operator ==(covariant RecipeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.image == image &&
        other.imageType == imageType &&
        other.servings == servings &&
        other.readyInMinutes == readyInMinutes &&
        other.cookingMinutes == cookingMinutes &&
        other.preparationMinutes == preparationMinutes &&
        listEquals(other.analyzedInstructions, analyzedInstructions) &&
        other.instructions == instructions &&
        listEquals(other.extendedIngredients, extendedIngredients) &&
        other.mealPlanDate == mealPlanDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        imageType.hashCode ^
        servings.hashCode ^
        readyInMinutes.hashCode ^
        cookingMinutes.hashCode ^
        preparationMinutes.hashCode ^
        analyzedInstructions.hashCode ^
        instructions.hashCode ^
        extendedIngredients.hashCode ^
        mealPlanDate.hashCode;
  }
}
