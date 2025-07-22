part of 'designation_cubit.dart';

abstract class DesignationState extends Equatable {
  const DesignationState();

  @override
  List<Object?> get props => [];
}

class DesignationInitial extends DesignationState {}

class DesignationLoaded extends DesignationState {
  final List<Designation>? data;


  DesignationLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class DesignationLoadingFailed extends DesignationState {
  final String? message;

  DesignationLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}