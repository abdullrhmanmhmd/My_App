import 'package:equatable/equatable.dart';

abstract class AllDoctorsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchAllDoctors extends AllDoctorsEvent {

   int? cityId;

  FetchAllDoctors(this.cityId);
}
