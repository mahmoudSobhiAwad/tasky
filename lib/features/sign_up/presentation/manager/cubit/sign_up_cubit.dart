import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_cubit_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpCubitInitial());
}
