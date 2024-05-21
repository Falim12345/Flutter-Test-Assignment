Flutter Test Assignment Documentation
Overview
This project is a Flutter-based mobile application designed as a test assignment. The main functionalities include user interface components, state management, and basic navigation.

Project Structure
main.dart: Entry point of the application. Sets up the main MyApp widget.

screens/: Contains the various screens of the application.

home_screen.dart: Defines the home screen layout and functionality.

details_screen.dart: Defines the details screen layout and functionality.

widgets/: Reusable UI components.

custom_button.dart: A custom button widget used across the app.

custom_card.dart: A card widget for displaying information.

models/: Data models used within the app.

item.dart: Model class for items displayed in the app.

services/: Contains services for data handling.

api_service.dart: Service for making API calls and fetching data.

Overview
NotificationService is a singleton class managing local notifications in a Flutter app using flutter_local_notifications and workmanager. It initializes the notification plugin and provides methods for displaying notifications.

Initialization
The service initializes the flutter_local_notifications plugin with Android-specific settings.

Show Notification
This method displays a local notification with a specified title and body, using high-priority settings for Android.

Workmanager Callback
Defines a background task handler using workmanager to display notifications with dynamic content.

Usage
Initialize the service:
Create an instance and call init().
Show a notification:
Use showNotification(title, body).
Configure workmanager:
Initialize with callbackDispatcher.
Dependencies
flutter_local_notifications: For local notifications.
workmanager: For background task execution.
MethodChannelHelper Documentation
Overview
MethodChannelHelper is a class designed to facilitate communication between Flutter and native platform code. It uses the MethodChannel API to invoke methods implemented on the native side (Android or iOS).

Class Definition
The class defines a static MethodChannel with a specified channel name ('URL').

Methods
invokeNativeMethod
Purpose: Invokes a method on the native platform.
Parameters:
methodName (String): The name of the method to invoke.
arguments (dynamic, optional): Arguments to pass to the native method.
Usage:
Attempts to invoke the specified method on the native platform.
Catches and prints any PlatformException errors that occur during invocation.

DatabaseRepository Documentation
Overview
DatabaseRepository is a singleton class managing a SQLite database in a Flutter application using the sqflite package. It provides methods to initialize the database, create tables, and perform CRUD operations on a "buildings" table.

Class Definition
Singleton Pattern: Ensures a single instance of the class is used.
Database Initialization: Lazy initialization of the database when accessed.
Methods
database
Purpose: Getter for the database instance, initializes if null.
Returns: A Database instance.
_initDatabase
Purpose: Initializes the database by setting its path and version.
Returns: An opened Database instance.
_onCreate
Purpose: Callback to create the "buildings" table during database initialization.
Parameters: db (Database), version (int).
insertBuilding
Purpose: Inserts a new row into the "buildings" table.
Parameters: row (Map<String, dynamic>).
Returns: The ID of the inserted row.
queryAllBuildings
Purpose: Retrieves all rows from the "buildings" table.
Returns: A list of maps, each representing a row.
updateCurrentFloor
Purpose: Updates the currentFloor of a specific building by its ID.
Parameters: id (int), newFloor (int).
Returns: The number of affected rows.
getBuildingById
Purpose: Retrieves a building by its ID.
Parameters: id (int).
Returns: A map representing the building.
Throws: Exception if the building is not found.

BuildingCubit Documentation
Overview
BuildingCubit is a BLoC (Business Logic Component) class managing the state of building data in a Flutter application. It interacts with DatabaseRepository to perform database operations and emits states based on these operations.

Class Definition
Extends: Cubit<BuildingState>
State Management: Manages states for loading, adding, fetching, and updating buildings.
Constructor
Parameters:
databaseRepository: An instance of DatabaseRepository.
Initial State: BuildingLoading
Methods
addBuilding
Purpose: Adds a new building to the database.
Parameters:
name (String): Name of the building.
numberOfFloors (int): Total floors in the building.
State Transitions:
Emits BuildingLoading during operation.
Emits BuildingAdded with the new building's ID on success.
Emits BuildingError on failure.
fetchBuildings
Purpose: Fetches all buildings from the database.
State Transitions:
Emits BuildingLoading during operation.
Emits BuildingLoaded with a list of buildings on success.
Emits BuildingError on failure.
updateCurrentFloor
Purpose: Updates the current floor of a specified building.
Parameters:
id (int): Building ID.
newFloor (int): New current floor.
State Transitions:
Emits BuildingError on failure.
Additional Operations:
Registers a periodic task using Workmanager to update the floor periodically.
State Management
BuildingLoading: Indicates loading state.
BuildingAdded: Indicates a building has been added successfully.
BuildingLoaded: Indicates buildings have been loaded successfully.
BuildingError: Indicates an error occurred.
Dependencies
bloc: For state management.
DatabaseRepository: For database operations.
workmanager: For background tasks.
