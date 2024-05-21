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
/// NotificationService Documentation

 Overview
 NotificationService is a singleton class that manages local notifications 
 in a Flutter application using the flutter_local_notifications and workmanager packages. 
 It initializes the notification plugin and provides methods to display notifications.

 Class Definition
class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   Initialization
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

   Show Notification
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }
}

 Workmanager Callback
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationService notificationService = NotificationService();
    String buildingName = inputData!['buildingName'];
    int currentFloor = inputData['currentFloor'];
    await notificationService.showNotification(
      'Elevator Update',
      'Current floor in $buildingName is $currentFloor',
    );
    return Future.value(true);
  });
}

 Usage
 Initialize the service:
 NotificationService notificationService = NotificationService();
 await notificationService.init();

 Show a notification:
 await notificationService.showNotification('Title', 'Body');

 Configure workmanager to use the callback dispatcher:
 Workmanager().initialize(callbackDispatcher);

 Dependencies
 - flutter_local_notifications: For handling local notifications.
 - workmanager: For executing background tasks.
