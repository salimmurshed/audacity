import 'package:audacity/Model/TrendingProductsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingProductBloc
    extends Bloc<TrendingProductEvent, TrendingProductState> {
  TrendingProductsRepository repository;

  TrendingProductBloc({this.repository}) : super(null);

  TrendingProductState get initialState => TrendingProductInitialState();
  @override
  Stream<TrendingProductState> mapEventToState(
      TrendingProductEvent event) async* {
    if (event is FetchTrendingProductEvent) {
      yield TrendingProductLoadingState();

      try {
        List<TrendingProductsModel> trendingProduct =
            await repository.getTrendingProductss();
        yield TrendingProductLoadedState(trendingProduct: trendingProduct);
      } catch (e) {
        yield TrendingProductErrorState(message: e.toString());
      }
    }
  }
}

abstract class TrendingProductEvent extends Equatable {}

class FetchTrendingProductEvent extends TrendingProductEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class TrendingProductState extends Equatable {}

class TrendingProductInitialState extends TrendingProductState {
  @override
  List<Object> get props => [];
}

class TrendingProductLoadingState extends TrendingProductState {
  @override
  List<Object> get props => [];
}

class TrendingProductLoadedState extends TrendingProductState {
  List<TrendingProductsModel> trendingProduct;
  TrendingProductLoadedState({this.trendingProduct});
  @override
  List<Object> get props => null;
}

class TrendingProductErrorState extends TrendingProductState {
  String message;
  TrendingProductErrorState({this.message});
  @override
  List<Object> get props => null;
}
