part of 'office_assets_cubit.dart';

abstract class OfficeAssetsState extends Equatable {
  const OfficeAssetsState();

  @override
  List<Object?> get props => [];
}

class OfficeAssetsInitial extends OfficeAssetsState {}

class OfficeAssetsLoaded extends OfficeAssetsState {
  final OfficeAssets? data;

  OfficeAssetsLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class OfficeAssetsLoadingFailed extends OfficeAssetsState {
  final String? message;

  OfficeAssetsLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}