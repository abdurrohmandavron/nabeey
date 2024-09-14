import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AuthorVideosCubit extends Cubit<void> {
  AuthorVideosCubit() : super(null);

  final ScrollController scrollController = ScrollController();

  void scrollToIndex(int index) {
    double scrollOffset = index * 300.0;
    scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
