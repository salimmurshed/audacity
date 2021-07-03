import 'package:audacity/Model/NewShopsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewShopBloc extends Bloc<NewShopEvent, NewShopState> {
  NewShopRepository repository;

  NewShopBloc({this.repository}) : super(null);

  NewShopState get initialState => NewShopInitialState();
  @override
  Stream<NewShopState> mapEventToState(NewShopEvent event) async* {
    if (event is FetchNewShopEvent) {
      yield NewShopLoadingState();

      try {
        List<NewShopsModel> newShop = await repository.getNewShops();
        yield NewShopLoadedState(newShop: newShop);
      } catch (e) {
        yield NewShopErrorState(message: e.toString());
      }
    }
  }
}

abstract class NewShopEvent extends Equatable {}

class FetchNewShopEvent extends NewShopEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class NewShopState extends Equatable {}

class NewShopInitialState extends NewShopState {
  @override
  List<Object> get props => [];
}

class NewShopLoadingState extends NewShopState {
  @override
  List<Object> get props => [];
}

class NewShopLoadedState extends NewShopState {
  List<NewShopsModel> newShop;
  NewShopLoadedState({this.newShop});
  @override
  List<Object> get props => null;
}

class NewShopErrorState extends NewShopState {
  String message;
  NewShopErrorState({this.message});
  @override
  List<Object> get props => null;
}
