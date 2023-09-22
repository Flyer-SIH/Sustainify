class Product {
  final String heading;
  final int quantity;
  final String state;

  Product({
    required this.heading,
    required this.quantity,
    required this.state,
  });

  // Factory constructor to create a Product instance from a map (e.g., JSON)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      heading: json['heading'] as String,
      quantity: json['quantity'] as int,
      state: json['state'] as String,
    );
  }

  // Method to convert a Product instance to a map (e.g., for serialization)
  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'quantity': quantity,
      'state': state,
    };
  }
}
