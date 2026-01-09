// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      cuisine: fields[3] as String,
      rating: fields[4] as double,
      servings: fields[5] as int,
      prepTimeMinutes: fields[6] as int,
      cookTimeMinutes: fields[7] as int,
      difficulty: fields[8] as String,
      ingredients: (fields[9] as List).cast<String>(),
      instructions: (fields[10] as List).cast<String>(),
      caloriesPerServing: fields[11] as int,
      tags: (fields[12] as List).cast<String>(),
      mealType: (fields[13] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.cuisine)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.servings)
      ..writeByte(6)
      ..write(obj.prepTimeMinutes)
      ..writeByte(7)
      ..write(obj.cookTimeMinutes)
      ..writeByte(8)
      ..write(obj.difficulty)
      ..writeByte(9)
      ..write(obj.ingredients)
      ..writeByte(10)
      ..write(obj.instructions)
      ..writeByte(11)
      ..write(obj.caloriesPerServing)
      ..writeByte(12)
      ..write(obj.tags)
      ..writeByte(13)
      ..write(obj.mealType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
