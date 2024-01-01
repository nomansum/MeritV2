// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class School {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String slug;
  final bool is_active;
  School({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.slug,
    required this.is_active,
  });

  School copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? slug,
    bool? is_active,
  }) {
    return School(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      slug: slug ?? this.slug,
      is_active: is_active ?? this.is_active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'slug': slug,
      'is_active': is_active,
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      slug: map['slug'] as String,
      is_active: map['is_active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory School.fromJson(String source) =>
      School.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'School(id: $id, name: $name, phone: $phone, address: $address, slug: $slug, is_active: $is_active)';
  }

  @override
  bool operator ==(covariant School other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.slug == slug &&
        other.is_active == is_active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        slug.hashCode ^
        is_active.hashCode;
  }
}
