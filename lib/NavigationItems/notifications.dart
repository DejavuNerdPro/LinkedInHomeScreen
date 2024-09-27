import 'package:flutter/material.dart';

class Notifications extends StatefulWidget{
  const Notifications({super.key});

  @override
  State<StatefulWidget> createState() =>NotificationsState();
  
}

class NotificationsState extends State<Notifications>{
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notification Home'),);
  }
  
}