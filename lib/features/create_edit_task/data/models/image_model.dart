class ImageModel {
  String? imagePath;
  ImageType imageType;
  ImageModel({this.imageType = ImageType.empty,this.imagePath});
}

enum ImageType { file, network,empty }
