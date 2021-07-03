import 'package:audacity/Model/ProductsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;

  ProductBloc({this.repository}) : super(null);

  ProductState get initialState => ProductInitialState();
  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();

      try {
        List<ProductsModel> prod = await repository.getProducts();
        yield ProductLoadedState(prod: prod);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}

abstract class ProductEvent extends Equatable {}

class FetchProductEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  List<ProductsModel> prod;
  ProductLoadedState({this.prod});
  @override
  List<Object> get props => null;
}

class ProductErrorState extends ProductState {
  String message;
  ProductErrorState({this.message});
  @override
  List<Object> get props => null;
}
