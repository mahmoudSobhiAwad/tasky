class ImageModel {
  String? imagePath;
  ImageType imageType;
  ImageModel({this.imageType = ImageType.empty, this.imagePath});
  ImageModel? copyWith({String? imagePath, ImageType? imageType}) {
    return ImageModel(
      imagePath: imagePath ?? this.imagePath,
      imageType: imageType ?? this.imageType,
    );
  }
}

enum ImageType { file, network, empty }
