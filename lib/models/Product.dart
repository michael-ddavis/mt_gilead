
class Product {
  final String id;
  final String image;
  final String title;
  final String date;
  final String price;
  final String description;

  const Product(
      {this.id,
      this.image,
      this.title,
      this.date,
      this.price,
      this.description,});

  Product.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          image: data['image'],
          title: data['title'],
          date: data['date'],
          price: data['price'],
          description: data['description'],
        );
}
