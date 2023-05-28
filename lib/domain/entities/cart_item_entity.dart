import 'package:weather/core/entities/base_entity.dart';

class CartItemEntity extends BaseEntity {
  final int id;
  final int productId;
  final int specificationId;
  final int quantity;
  final String name;
  final String image;
  final double price;

  CartItemEntity(this.id,{ this.productId, this.specificationId, this.quantity,
      this.name, this.image, this.price});

  @override
  List<Object> get props => [id, productId, specificationId, quantity, name, image, price];
}
