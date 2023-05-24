class SelectedImage {
  final String? imagePath;
  final String? name;
  bool? isSelected;

  SelectedImage({this.imagePath, this.name, this.isSelected = false});

  @override
  String toString() {
    // TODO: implement toString
    return "Image : (imagePath : $imagePath, name : $name isSelected : $isSelected)";
  }
}
