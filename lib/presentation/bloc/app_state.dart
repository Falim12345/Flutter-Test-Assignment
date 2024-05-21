part of 'app_cubit.dart';

abstract class BuildingState {}

class BuildingInitial extends BuildingState {}

class BuildingLoading extends BuildingState {}

class BuildingAdded extends BuildingState {
  final int id;

  BuildingAdded(this.id);
}

class BuildingLoaded extends BuildingState {
  final List<Map<String, dynamic>> buildings;

  BuildingLoaded(this.buildings);
}

class BuildingError extends BuildingState {
  final String message;

  BuildingError(this.message);
}
