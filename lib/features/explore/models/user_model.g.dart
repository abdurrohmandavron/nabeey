// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1; // Unique identifier for this adapter

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte(); // Read the number of fields
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      asset: fields[7] as FileModel?, // Read asset (nullable)
      id: fields[1] as int, // Read id
      phone: fields[5] as String, // Read phone
      email: fields[4] as String, // Read email
      userRole: fields[6] as int, // Read userRole
      lastName: fields[3] as String, // Read lastName
      firstName: fields[2] as String, // Read firstName
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7) // Total number of fields
      ..writeByte(1) // Field index for id
      ..write(obj.id) // Write id
      ..writeByte(2) // Field index for firstName
      ..write(obj.firstName) // Write firstName
      ..writeByte(3) // Field index for lastName
      ..write(obj.lastName) // Write lastName
      ..writeByte(4) // Field index for email
      ..write(obj.email) // Write email
      ..writeByte(5) // Field index for phone
      ..write(obj.phone) // Write phone
      ..writeByte(6) // Field index for userRole
      ..write(obj.userRole) // Write userRole
      ..writeByte(7) // Field index for asset
      ..write(obj.asset); // Write asset
  }

  @override
  int get hashCode => typeId.hashCode; // Unique hash for the adapter

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId; // Equality check
}
