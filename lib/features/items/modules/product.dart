import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductModule {
  final String id;
  final String name;
  final int pointsPerKg;
  final String image;
  int weight;
  ProductModule({
    required this.id,
    required this.name,
    required this.pointsPerKg,
    required this.image,
    required this.weight,
  });

  factory ProductModule.create(
      {required String name,
      required int pointsPerKg,
      required int weight,
      String image = ""}) {
    final String productId = const Uuid().v1();
    return ProductModule(
      id: productId,
      name: name,
      pointsPerKg: pointsPerKg,
      weight: weight,
      image: image,
    );
  }

  factory ProductModule.fromJson(Map<String, dynamic> json) => ProductModule(
        id: json["id"],
        name: json["name"],
        pointsPerKg: json["pointsPerKg"],
        weight: json["weight"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pointsPerKg': pointsPerKg,
        'image': image,
        'weight': weight
      };

  ProductModule copyWith({
    String? id,
    String? name,
    int? weight,
    int? pointsPerKg,
    String? image,
  }) {
    return ProductModule(
      id: this.id,
      name: this.name,
      weight: weight ?? this.weight,
      pointsPerKg: this.pointsPerKg,
      image: this.image,
    );
  }

  factory ProductModule.fromSnapshot(DocumentSnapshot snapshot) {
    return ProductModule(
      id: snapshot["id"],
      name: snapshot["name"],
      pointsPerKg: snapshot["pointsPerKg"],
      weight: snapshot["weight"],
      image: snapshot["image"],
    );
  }
}
