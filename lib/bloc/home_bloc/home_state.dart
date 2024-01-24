part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final int pageIndex;
  const HomeState({required this.pageIndex});
}

class HomeInitial extends HomeState {

  const HomeInitial({required super.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
