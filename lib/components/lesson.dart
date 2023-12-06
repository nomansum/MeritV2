// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Lesson {
  final int id;
  final String name;
  final String start_time;
  final String week_day;
  final int subject;
  Lesson({
    required this.id,
    required this.name,
    required this.start_time,
    required this.week_day,
    required this.subject,
  });

  Lesson copyWith({
    int? id,
    String? name,
    String? start_time,
    String? week_day,
    int? subject,
  }) {
    return Lesson(
      id: id ?? this.id,
      name: name ?? this.name,
      start_time: start_time ?? this.start_time,
      week_day: week_day ?? this.week_day,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start_time': start_time,
      'week_day': week_day,
      'subject': subject,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as int,
      name: map['name'] as String,
      start_time: map['start_time'] as String,
      week_day: map['week_day'] as String,
      subject: map['subject'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lesson(id: $id, name: $name, start_time: $start_time, week_day: $week_day, subject: $subject)';
  }

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.start_time == start_time &&
        other.week_day == week_day &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        start_time.hashCode ^
        week_day.hashCode ^
        subject.hashCode;
  }
}
