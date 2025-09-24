import 'package:bloc/bloc.dart';

class DashBoardCubit extends Cubit<int> {
  DashBoardCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
