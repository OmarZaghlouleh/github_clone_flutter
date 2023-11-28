

import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPasswordVisibilityCubit extends Cubit<bool> {
  SignInPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
