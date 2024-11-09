import 'package:flutter/material.dart';
import '../services/socket_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _socketService.connect(); // Connect to the Socket.IO server
  }

  @override
  void dispose() {
    _socketService.disconnect(); // Disconnect when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Listening for notifications...'),
      ),
    );
  }
}
