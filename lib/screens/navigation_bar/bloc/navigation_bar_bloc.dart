import 'package:equatable/equatable.dart';

import '../../../bloc/bloc_export.dart';

part 'navigation_bar_event.dart';

part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(const NavigationBarInitialState()) {
    on<NavigationBarEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NavigationBarChangeEvent>(_navigationBarChange);
  }

  _navigationBarChange(
      NavigationBarChangeEvent event, Emitter<NavigationBarState> emit) {
    emit(NavigationBarChangeState(event.newIndex));
  }
}
