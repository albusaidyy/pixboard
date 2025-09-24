import 'package:bloc/bloc.dart';

class ProfileCubit extends Cubit<int> {
  ProfileCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
