import 'package:audacity/Model/ProductsModel.dart';
import 'package:audacity/Model/TredinSellerModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TredinSellerBloc extends Bloc<TredinSellerEvent, TredinSellerState> {
  TredinSellersRepository repository;

  TredinSellerBloc({this.repository}) : super(null);

  TredinSellerState get initialState => TredinSellerInitialState();
  @override
  Stream<TredinSellerState> mapEventToState(TredinSellerEvent event) async* {
    if (event is FetchTredinSellerEvent) {
      yield TredinSellerLoadingState();

      try {
        List<TredinSellersModel> tredinSeller =
            await repository.getTredinSellerss();
        yield TredinSellerLoadedState(tredinSeller: tredinSeller);
      } catch (e) {
        yield TredinSellerErrorState(message: e.toString());
      }
    }
  }
}

abstract class TredinSellerEvent extends Equatable {}

class FetchTredinSellerEvent extends TredinSellerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class TredinSellerState extends Equatable {}

class TredinSellerInitialState extends TredinSellerState {
  @override
  List<Object> get props => [];
}

class TredinSellerLoadingState extends TredinSellerState {
  @override
  List<Object> get props => [];
}

class TredinSellerLoadedState extends TredinSellerState {
  List<TredinSellersModel> tredinSeller;
  TredinSellerLoadedState({this.tredinSeller});
  @override
  List<Object> get props => null;
}

class TredinSellerErrorState extends TredinSellerState {
  String message;
  TredinSellerErrorState({this.message});
  @override
  List<Object> get props => null;
}
