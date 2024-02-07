import 'dart:typed_data';

class CategoryDatabaseModel {
  int id;
  String category_name;
  // Uint8List? categoryImage;

  CategoryDatabaseModel({
    required this.id,
    required this.category_name,
    // this.categoryImage
  });

  factory CategoryDatabaseModel.formMap({required Map data}) {
    return CategoryDatabaseModel(
      id: data['id'],
      category_name: data['category_name'],
      // categoryImage: data['quotes-image'],
    );
  }
}
