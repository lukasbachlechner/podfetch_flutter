import 'package:podfetch_api/models/model.dart';
import 'package:podfetch_api/podfetch_api.dart';

class Category implements Model {
  final int id;
  final String name;
  final String slug;

  Category(this.id, this.name, this.slug);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json['id'] as int,
        json['name'] as String,
        json['slug'] as String,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'slug': slug,
      };
}
