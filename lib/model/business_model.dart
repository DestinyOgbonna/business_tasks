class Business {
  final String id;
  final String name;
  final String category;
  final String address;
  final String phone;
  final String email;
  final List<String> services;
  final double rating;
  final String description;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.phone,
    required this.email,
    required this.services,
    required this.rating,
    required this.description,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      services: List<String>.from(json['services']),
      rating: json['rating'].toDouble(),
      description: json['description'],
    );
  }
}