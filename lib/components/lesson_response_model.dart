// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LessonModel {
  final int id;
  final String name;
  final String week_day;
  final String start_time;
  final int teacherId;
  LessonModel({
    required this.id,
    required this.name,
    required this.week_day,
    required this.start_time,
    required this.teacherId,
  });
}
