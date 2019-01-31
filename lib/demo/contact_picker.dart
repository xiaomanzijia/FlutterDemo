import 'dart:async';

import 'package:flutter/services.dart';

class ContactPicker {
  static const MethodChannel _channel = const MethodChannel('contact_picker');

  Future<Contact> selectContact() async {
    final Map<dynamic, dynamic> result =
    await _channel.invokeMethod('selectContact');

    if (result == null) {
      return null;
    }
    return new Contact.fromMap(result);
  }
}

class Contact {
  final String fullName;

  final PhoneNumber phoneNumber;

  Contact(this.fullName, this.phoneNumber);

  factory Contact.fromMap(Map<dynamic, dynamic> map) =>
      new Contact(map['fullName'], new PhoneNumber.fromMap(map['phoneNumber']));

  @override
  String toString() => '$fullName:$phoneNumber';


}

class PhoneNumber {
  PhoneNumber(this.number, this.label);

  final String number;
  final String label;

  factory PhoneNumber.fromMap(Map<dynamic, dynamic> map) =>
      new PhoneNumber(map['number'], map['label']);

  @override
  String toString() => '$number($label)';
}
