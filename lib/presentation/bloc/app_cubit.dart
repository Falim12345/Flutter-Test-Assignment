import 'package:bloc/bloc.dart';
import 'package:flutter_application_6/repo/data_base_rep.dart';
import 'package:workmanager/workmanager.dart';

part 'app_state.dart';

class BuildingCubit extends Cubit<BuildingState> {
  final DatabaseRepository databaseRepository;

  BuildingCubit(this.databaseRepository) : super(BuildingLoading()) {
    fetchBuildings();
  }

  Future<void> addBuilding(String name, int numberOfFloors) async {
    emit(BuildingLoading());
    try {
      final id = await databaseRepository.insertBuilding({
        'name': name,
        'numberOfFloors': numberOfFloors,
      });
      emit(BuildingAdded(id));
    } catch (e) {
      emit(BuildingError("Failed to add building"));
    }
  }

  Future<void> fetchBuildings() async {
    try {
      final buildings = await databaseRepository.queryAllBuildings();
      emit(BuildingLoaded(buildings));
    } catch (e) {
      emit(BuildingError("Failed to load buildings"));
    }
  }

  Future<void> updateCurrentFloor(int id, int newFloor) async {
    try {
      await databaseRepository.updateCurrentFloor(id, newFloor);
      final building = await databaseRepository.getBuildingById(id);
      Workmanager().registerPeriodicTask(
        "1",
        "simplePeriodicTask",
        inputData: {
          'buildingName': building['name'],
          'currentFloor': newFloor,
        },
        frequency: Duration(minutes: 1),
      );
    } catch (e) {
      emit(BuildingError("Failed to update current floor"));
    }
  }
}
