import 'package:bloc/bloc.dart';

class SignupProfileImageHoverCubit extends Cubit<bool> {
  SignupProfileImageHoverCubit() : super(true);

  void toggleHover(bool hover) {
    emit(hover);
  }

  void setHover(bool hover) {
    emit(hover);
  }
}
