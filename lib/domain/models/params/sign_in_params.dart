// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SigninParams extends Equatable {
  final String accountName;
  final String password;
  final String cName;
  const SigninParams({
    required this.accountName,
    required this.password,
    required this.cName,
  });

  Map<String, dynamic> toJson() => {
        'account_name': accountName,
        'password': password,
        'c_name': cName,
      };

  @override
  List<Object> get props {
    return [accountName, password, cName];
  }
}
