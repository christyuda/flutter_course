import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 1;

  @override
  ProductEntity read(BinaryReader reader) {
    return ProductEntity(
      id: reader.readString(),
      name: reader.readString(),
      description: reader.readString(),
      category: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.category);
    writer.writeDouble(obj.price);
  }
}
