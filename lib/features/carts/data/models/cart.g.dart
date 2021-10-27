// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 3;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      id: fields[0] as String?,
      keyCart: fields[1] as String,
      cartItems: (fields[2] as List).cast<CartItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.keyCart)
      ..writeByte(2)
      ..write(obj.cartItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
