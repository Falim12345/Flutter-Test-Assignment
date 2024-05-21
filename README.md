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
