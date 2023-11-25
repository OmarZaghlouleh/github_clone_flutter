import 'package:bloc/bloc.dart';

class SignInPasswordVisibilityCubit extends Cubit<bool> {
  SignInPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
