import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'notification_service.dart';

class SocketService {
  late IO.Socket socket;
  final NotificationService _notificationService = NotificationService();

  Future<void> connect() async {
    await _notificationService.initialize(); // Initialize notifications

    socket = IO.io('http://localhost:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('notification', (data) {
      print('Notification received: $data');
      // Show the local notification
      _notificationService.showNotification('New Notification', data['message']);
    });

    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
