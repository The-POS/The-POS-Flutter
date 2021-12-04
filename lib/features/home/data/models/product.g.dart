// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      sku: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as double,
      taxRate: fields[3] as double?,
      taxedPrice: fields[4] as double?,
      salePrice: fields[5] as double?,
      taxedSalePrice: fields[6] as double?,
      available: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sku)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.taxRate)
      ..writeByte(4)
      ..write(obj.taxedPrice)
      ..writeByte(5)
      ..write(obj.salePrice)
      ..writeByte(6)
      ..write(obj.taxedSalePrice)
      ..writeByte(7)
      ..write(obj.available);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
