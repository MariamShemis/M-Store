abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductSuccessState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String message;

  AddProductErrorState(this.message);
}