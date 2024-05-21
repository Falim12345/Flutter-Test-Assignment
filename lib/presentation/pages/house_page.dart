import 'package:flutter/material.dart';
import 'package:flutter_application_6/presentation/bloc/app_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/elivator.dart';
import 'lift_page.dart';

class SelectedBuilding extends ChangeNotifier {
  late Map<String, dynamic> _selectedBuilding;

  Map<String, dynamic> get building => _selectedBuilding;

  void setBuilding(Map<String, dynamic> building) {
    _selectedBuilding = building;
    notifyListeners();
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final nameController = TextEditingController();
                    final floorsController = TextEditingController();

                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 320,
                        height: 320,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Add Building',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: 'Building Name',
                              ),
                            ),
                            TextField(
                              controller: floorsController,
                              decoration: const InputDecoration(
                                labelText: 'Number of Floors',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  final name = nameController.text;
                                  final floors =
                                      int.tryParse(floorsController.text) ?? 0;
                                  context
                                      .read<BuildingCubit>()
                                      .addBuilding(name, floors);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Add'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Row(
                children: [
                  Text('Add house'),
                  Icon(Icons.add),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<BuildingCubit, BuildingState>(
                listener: (context, state) {
                  if (state is BuildingAdded) {
                    context.read<BuildingCubit>().fetchBuildings();
                  }
                },
                builder: (context, state) {
                  if (state is BuildingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BuildingLoaded) {
                    return ListView.builder(
                      itemCount: state.buildings.length,
                      itemBuilder: (context, index) {
                        final building = state.buildings[index];
                        return ListTile(
                          title: Text(building['name']),
                          subtitle:
                              Text('Floors: ${building['numberOfFloors']}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => Elevator(),
                                  child: BuildingDetailPage(building: building),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is BuildingError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
