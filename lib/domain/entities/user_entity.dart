import '../../core/entities/base_entity.dart';

// ignore: must_be_immutable
class UserEntity extends BaseEntity {
  int id;
  String name;
  String email;
  String phoneNumber;
  String avatar;
  String emailVerifiedAt;
  String phoneVerifiedAt;
  int isActive;

  UserEntity(
      this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.avatar,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.isActive,
   );

  @override
  List<Object> get props => [id, name, email, phoneNumber,avatar, isActive];
}
