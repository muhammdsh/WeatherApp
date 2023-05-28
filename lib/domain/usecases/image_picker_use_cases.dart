import 'package:weather/core/param/no_param.dart';
import 'package:weather/core/services/image_picker_service.dart';
import 'package:weather/domain/entities/file_entity.dart';

import '../../core/usecases/base_use_case.dart';

class GetImageFromCameraUseCase extends UseCase<Future<FileEntity>, NoParams> {
  final ImagePickerService imagePickerService;

  GetImageFromCameraUseCase(this.imagePickerService);

  @override
  Future<FileEntity> call(NoParams params) async {
    final file = await imagePickerService.getImageFromCamera();

    return FileEntity(name: file.name, path: file.path);
  }
}

class GetImageFromGalleryUseCase extends UseCase<Future<FileEntity>, NoParams> {
  final ImagePickerService imagePickerService;

  GetImageFromGalleryUseCase(this.imagePickerService);

  @override
  Future<FileEntity> call(NoParams params) async {
    final file = await imagePickerService.getImageFromGallery();

    return FileEntity(name: file.name, path: file.path);
  }
}

class GetMultipleImageFromGalleryUseCase
    extends UseCase<Future<List<FileEntity>>, NoParams> {
  final ImagePickerService imagePickerService;

  GetMultipleImageFromGalleryUseCase(this.imagePickerService);

  @override
  Future<List<FileEntity>> call(NoParams params) async {
    final files = await imagePickerService.getMultiImage();

    return files
        .map((file) => FileEntity(name: file.name, path: file.path))
        .toList();
  }
}
