class SelectedImage {
  final String? imagePath;
  bool? isSelected;

  SelectedImage({this.imagePath, this.isSelected = false});

  @override
  String toString() {
    // TODO: implement toString
    return "Image : (imagePath : ${imagePath}, isSelected : ${isSelected})";
  }
}
