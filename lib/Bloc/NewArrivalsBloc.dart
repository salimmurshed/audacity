import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  NewArrivalRepository repository;

  NewArrivalBloc({this.repository}) : super(null);

  NewArrivalState get initialState => NewArrivalInitialState();
  @override
  Stream<NewArrivalState> mapEventToState(NewArrivalEvent event) async* {
    if (event is FetchNewArrivalEvent) {
      yield NewArrivalLoadingState();

      try {
        List<NewArrivalsModel> newArrival = await repository.getNewArrivals();
        yield NewArrivalLoadedState(newArrival: newArrival);
      } catch (e) {
        yield NewArrivalErrorState(message: e.toString());
      }
    }
  }
}

abstract class NewArrivalEvent extends Equatable {}

class FetchNewArrivalEvent extends NewArrivalEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class NewArrivalState extends Equatable {}

class NewArrivalInitialState extends NewArrivalState {
  @override
  List<Object> get props => [];
}

class NewArrivalLoadingState extends NewArrivalState {
  @override
  List<Object> get props => [];
}

class NewArrivalLoadedState extends NewArrivalState {
  List<NewArrivalsModel> newArrival;
  NewArrivalLoadedState({this.newArrival});
  @override
  List<Object> get props => null;
}

class NewArrivalErrorState extends NewArrivalState {
  String message;
  NewArrivalErrorState({this.message});
  @override
  List<Object> get props => null;
}
