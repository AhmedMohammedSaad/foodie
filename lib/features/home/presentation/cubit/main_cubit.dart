import 'package:flutter_bloc/flutter_bloc.dart';

class MainState {
  final int currentIndex;
  final bool isNavbarVisible;

  const MainState({
    this.currentIndex = 0,
    this.isNavbarVisible = true,
  });

  MainState copyWith({
    int? currentIndex,
    bool? isNavbarVisible,
  }) {
    return MainState(
      currentIndex: currentIndex ?? this.currentIndex,
      isNavbarVisible: isNavbarVisible ?? this.isNavbarVisible,
    );
  }
}

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void setNavbarVisibility(bool isVisible) {
    if (state.isNavbarVisible != isVisible) {
      emit(state.copyWith(isNavbarVisible: isVisible));
    }
  }
}
