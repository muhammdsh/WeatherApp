// import 'package:weather/core/models/base_model.dart';
// import 'package:weather/domain/entities/location_entity.dart';
//
// class CategoryModel extends BaseModel<LocationEntity> {
//   int id;
//   String name;
//   String description;
//   int parentId;
//   int publish;
//   String color;
//   String image;
//   bool hasChild;
//
//   CategoryModel(
//       {this.id,
//       this.name,
//       this.description,
//       this.parentId,
//       this.publish,
//       this.color,
//       this.hasChild,
//       this.image});
//
//   CategoryModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     parentId = json['parent_id'];
//     publish = json['publish'];
//     color = json['color'];
//     image = json['image'];
//     print('hasChilde:${json['id']} ${json['has_child']}');
//     hasChild = json['has_child'].toString() == "1" ? true : false;
//     print('hasChilde:${json['id']} ${hasChild}');
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['parent_id'] = this.parentId;
//     data['publish'] = this.publish;
//     data['color'] = this.color;
//     data['has'] = this.hasChild;
//     data['image'] = this.image;
//     return data;
//   }
//
//   @override
//   LocationEntity toEntity() => LocationEntity(
//     //  description: description,
//     //  id: id,
//       name: name,
//     //  parentId: parentId,
//    //   publish: publish,
// //      hasChildren: hasChild,
//   //    color: color,
//     //  image: image
//   );
// }
