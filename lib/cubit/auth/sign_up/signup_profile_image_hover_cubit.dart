import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProfileImageHoverCubit extends Cubit<bool> {
  SignupProfileImageHoverCubit() : super(true);

  void toggleHover(bool hover) {
    emit(hover);
  }

  void setHover(bool hover) {
    emit(hover);
  }
}
