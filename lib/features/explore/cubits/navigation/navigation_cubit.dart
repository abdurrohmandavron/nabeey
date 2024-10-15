import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(0));

  void onDestinationSelected(int index) {
    emit(HomeState(index));
  }
}

class HomeState extends Equatable {
  final int index;

  const HomeState(this.index);

  @override
  List<Object> get props => [index];
}
