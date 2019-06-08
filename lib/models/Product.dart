class Product {
  final String documentId;
  final String title;
  final String description;
  final String image;
  final String price;
  final List<dynamic> format;
  final List<dynamic> favorites;
  final String type;
  
  Product({this.documentId, this.title, this.description, this.image, this
      .price,
    this.format, this.favorites, this.type});

  Product.fromMap(Map<String, dynamic> data, String id)
      : this(
    documentId: id,
    title: data['title'],
    description: data['description'],
    image: data['image'],
    price: data['price'],
    format: data['format'],
    favorites: data['favorites'],
    type: data['type'],
  );
}
