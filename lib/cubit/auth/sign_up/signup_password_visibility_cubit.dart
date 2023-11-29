

import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPasswordVisibilityCubit extends Cubit<bool> {
  SignupPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
