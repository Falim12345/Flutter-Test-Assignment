import 'package:flutter/material.dart';
import 'package:flutter_application_6/presentation/bloc/app_cubit.dart';
import 'package:flutter_application_6/presentation/widgets/elivator.dart';
import 'package:provider/provider.dart';

class BuildingDetailPage extends StatelessWidget {
  final Map<String, dynamic> building;

  const BuildingDetailPage({Key? key, required this.building})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numberOfFloors = building['numberOfFloors'];
    final elevator = Provider.of<Elevator>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(building['name']),
      ),
      body: ListView.builder(
        itemCount: numberOfFloors,
        itemBuilder: (context, index) {
          final floor = index + 1;
          final isCurrentFloor = elevator.currentFloor == floor;
          final isMoving = elevator.isMoving;

          return Container(
            margin: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isMoving && isCurrentFloor
                    ? Colors.yellow
                    : isCurrentFloor
                        ? Colors.green
                        : null,
              ),
              onPressed: () async {
                await elevator.moveToFloor(floor, numberOfFloors);
                context
                    .read<BuildingCubit>()
                    .updateCurrentFloor(building['id'], elevator.currentFloor);
              },
              child: Text('Floor $floor'),
            ),
          );
        },
      ),
    );
  }
}
