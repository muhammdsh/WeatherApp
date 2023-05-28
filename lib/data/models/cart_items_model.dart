import 'package:weather/core/models/base_model.dart';

import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends BaseModel<CartItemEntity> {

  final int id;
  final int productId;
  final int specificationId;
  final int quantity;
  final String name;
  final String image;
  final double price;

  CartItemModel(this.id, this.productId, this.specificationId, this.quantity,
      this.name, this.image, {this.price});

  @override
  CartItemEntity toEntity() =>  CartItemEntity(id,productId:  productId,specificationId: specificationId,quantity: quantity,
      name: name,image: image, price: price);

}