class ProductCategory {
  final String image;
  final String title;
  final String type;

  const ProductCategory({
    this.image,
    this.title,
    this.type,
  });

  ProductCategory.fromMap(Map<String, dynamic> data, String id)
      : this(
          image: data['image'],
          title: data['title'],
          type: data['type'],
        );
}
