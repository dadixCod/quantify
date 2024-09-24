import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerItemCubit extends Cubit<int> {
  DrawerItemCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}