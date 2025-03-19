part of 'leaves_types_cubit.dart';

abstract class LeavesTypesState extends Equatable {
  const LeavesTypesState();

  @override
  List<Object?> get props => [];
}

class LeavesTypesInitial extends LeavesTypesState {}

class LeavesTypesLoaded extends LeavesTypesState {
  final List<LeavesTypes>? data;


  LeavesTypesLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class LeavesTypesLoadingFailed extends LeavesTypesState {
  final String? message;

  LeavesTypesLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}