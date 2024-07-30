import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/enums.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationEvent.home, 0));

  void getNavBarItem(NavigationEvent navigationEvent) {
    switch (navigationEvent) {
      case NavigationEvent.home:
        emit(const NavigationState(NavigationEvent.home, 0));
        break;
      case NavigationEvent.quiz:
        emit(const NavigationState(NavigationEvent.quiz, 1));
        break;
      case NavigationEvent.rating:
        emit(const NavigationState(NavigationEvent.rating, 2));
        break;
      case NavigationEvent.profile:
        emit(const NavigationState(NavigationEvent.profile, 3));
        break;
    }
  }
}

class NavigationState extends Equatable {
  final NavigationEvent navigationEvent;
  final int index;

  const NavigationState(this.navigationEvent, this.index);

  @override
  List<Object> get props => [NavigationEvent, index];
}
