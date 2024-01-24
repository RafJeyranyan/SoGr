part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {

  const HomeEvent();
}


class HomeChangePageEvent extends HomeEvent{
  final int pageIndex;
  const HomeChangePageEvent({required this.pageIndex});

  @override
  List<Object?> get props => [];


}