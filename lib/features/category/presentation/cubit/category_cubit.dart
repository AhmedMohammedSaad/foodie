import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void loadCategories() {
    emit(CategoryLoading());
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 600), () {
      emit(CategoryLoaded(
        categories: [
          {'name': 'Pizza', 'icon': 'assets/images/placeholder.png'}, // Use generic pizza icon or placeholder
          {'name': 'Burger', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Sushi', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Ramen', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Salads', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Drinks', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Desserts', 'icon': 'assets/images/placeholder.png'},
          {'name': 'Pasta', 'icon': 'assets/images/placeholder.png'},
        ]
      ));
    });
  }
}
