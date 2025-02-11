import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/base_repository.dart';

import 'package:nabeey/features/explore/blocs/base/base_event.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/features/quiz/models/quiz_model.dart';

class BaseBloc<T> extends Bloc<BaseEvent, BaseState> {
  final BaseRepository<T> _repository;

  AudioModel? playingAudio;

  BaseBloc(this._repository) : super(ItemsLoading()) {
    on<LoadItems>(_loadItems);

    add(LoadItems());
  }

  Future _loadItems(LoadItems event, Emitter<BaseState> emit) async {
    try {
      final List<T> items;
      if (T == CategoryModel || T == QuizModel) {
        items = await _repository.getAll();
      } else {
        items = await _repository.getByCategoryId();
      }

      items.isNotEmpty ? emit(ItemsLoaded<T>(items)) : emit(ItemsEmpty());
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}
