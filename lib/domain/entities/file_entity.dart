import 'package:weather/core/entities/base_entity.dart';

class FileEntity extends BaseEntity {

  final String name;
  final String path;


  FileEntity({this.name, this.path});

  @override
  List<Object> get props => [name, path];

}