import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class ItemsLoading extends BaseState {}

class ItemsLoaded<T> extends BaseState {
  final List<T> items;

  const ItemsLoaded(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => "Kontent yuklandi: $items";
}

class ItemsError extends BaseState {
  final String message;

  const ItemsError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "Xatolik: $message";
}

class ItemsEmpty extends BaseState {
  @override
  String toString() => "Kontent mavjud emas.";
}
