// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignupParams extends Equatable {
  final String fileName;
  final MemoryImage? profileImage;
  final String firstName;
  final String lastName;
  final String accountName;
  final String email;
  final String password;
  final String confirmPassword;
  final String cName;
  const SignupParams({
    required this.fileName,
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.accountName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.cName,
  });

  Map<String, dynamic> toJson() => {
        if (profileImage != null)
          'img': MultipartFile.fromBytes(
            profileImage!.bytes,
            filename: "-$fileName",
          ),
        'first_name': firstName,
        'last_name': lastName,
        'account_name': accountName,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'c_name': cName,
      };

  @override
  List<Object> get props {
    return [
      if (profileImage != null)
        MultipartFile.fromBytes(
          profileImage!.bytes,
          filename: "-$fileName",
        ),
      firstName,
      lastName,
      accountName,
      email,
      password,
      confirmPassword,
      cName
    ];
  }
}
