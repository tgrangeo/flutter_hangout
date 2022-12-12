import 'dart:ffi';

class SMS {
  final int? id;
  final String phone;
  final String message;
  final int contactId;
  final String me;

  const SMS({
    this.id,
    required this.contactId,
    required this.phone,
    required this.message,
    required this.me,
  });

  Map<String, dynamic> toMap() {
    return {
      'contactid': contactId,
      'phone': phone,
      'message': message,
      'me':me,
    };
  }
}
