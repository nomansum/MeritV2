// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Level {
  final int id;
  final String name;
  final String description;
  final String slug;
  final bool is_active;
  Level({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.is_active,
  });

  Level copyWith({
    int? id,
    String? name,
    String? description,
    String? slug,
    bool? is_active,
  }) {
    return Level(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      is_active: is_active ?? this.is_active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'slug': slug,
      'is_active': is_active,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      slug: map['slug'] as String,
      is_active: map['is_active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Level.fromJson(String source) =>
      Level.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Level(id: $id, name: $name, description: $description, slug: $slug, is_active: $is_active)';
  }

  @override
  bool operator ==(covariant Level other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.slug == slug &&
        other.is_active == is_active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        slug.hashCode ^
        is_active.hashCode;
  }
}
