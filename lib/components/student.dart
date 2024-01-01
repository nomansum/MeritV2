class Student {
  final int id;
  final User user;
  final String branch;
  final String level;
  final double due;
  final String school;
  final String yearGroup;
  final String studentId;
  final String resourcesFee;
  final String registrationFee;
  final String refundableDepositAmount;
  final String hourlyFee;
  final int score;
  final String assessmentDate;
  final String assessmentTime;
  final String status;
  final String? ieduStudentId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int parent;

  Student({
    required this.id,
    required this.user,
    required this.due,
    required this.branch,
    required this.level,
    required this.school,
    required this.yearGroup,
    required this.studentId,
    required this.resourcesFee,
    required this.registrationFee,
    required this.refundableDepositAmount,
    required this.hourlyFee,
    required this.score,
    required this.assessmentDate,
    required this.assessmentTime,
    required this.status,
    this.ieduStudentId,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.parent,
  });
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String address;
  final String postcode;
  final dynamic
      photo; // You can specify the correct type for the photo if needed.

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.address,
    required this.postcode,
    this.photo,
  });
}
