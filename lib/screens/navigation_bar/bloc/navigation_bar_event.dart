part of 'navigation_bar_bloc.dart';

abstract class NavigationBarEvent {}

class NavigationBarChangeEvent extends NavigationBarEvent {
  final int newIndex;

  NavigationBarChangeEvent(this.newIndex);
}
