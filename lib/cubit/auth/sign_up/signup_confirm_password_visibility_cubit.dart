

import 'package:flutter_bloc/flutter_bloc.dart';

class SignupConfirmPasswordVisibilityCubit extends Cubit<bool> {
  SignupConfirmPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
