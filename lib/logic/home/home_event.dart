import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchHomeData extends HomeEvent{}