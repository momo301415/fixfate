// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListenSettingAdapter extends TypeAdapter<ListenSetting> {
  @override
  final int typeId = 10;

  @override
  ListenSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListenSetting(
      times: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ListenSetting obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.times);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListenSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
