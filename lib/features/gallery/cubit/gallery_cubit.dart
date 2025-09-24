import 'package:bloc/bloc.dart';

class GalleryCubit extends Cubit<int> {
  GalleryCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
