import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "name": "Alex Johnson",
      "status": "last seen Yesterday at 08:45 PM",
      "online": false,
      "color": Colors.blue,
    },
    {
      "name": "Emma Wilson",
      "status": "online",
      "online": true,
      "color": Colors.orange,
    },
    {
      "name": "John Doe",
      "status": "last seen Today at 10:24 AM",
      "online": false,
      "color": Colors.green,
    },
    {
      "name": "Michael Smith",
      "status": "last seen Monday at 11:30 AM",
      "online": false,
      "color": Colors.purple,
    },
    {
      "name": "Sophia Brown",
      "status": "last seen Yesterday at 05:10 PM",
      "online": false,
      "color": Colors.red,
    },
    {
      "name": "William Parker",
      "status": "online",
      "online": true,
      "color": Colors.teal,
    },
    {
      "name": "Olivia Davis",
      "status": "last seen recently",
      "online": false,
      "color": Colors.indigo,
    },
    {
      "name": "Alex Johnson",
      "status": "last seen Yesterday at 08:45 PM",
      "online": false,
      "color": Colors.blue,
    },
    {
      "name": "Emma Wilson",
      "status": "online",
      "online": true,
      "color": Colors.orange,
    },
    {
      "name": "John Doe",
      "status": "last seen Today at 10:24 AM",
      "online": false,
      "color": Colors.green,
    },
    {
      "name": "Michael Smith",
      "status": "last seen Monday at 11:30 AM",
      "online": false,
      "color": Colors.purple,
    },
    {
      "name": "Sophia Brown",
      "status": "last seen Yesterday at 05:10 PM",
      "online": false,
      "color": Colors.red,
    },
    {
      "name": "William Parker",
      "status": "online",
      "online": true,
      "color": Colors.teal,
    },
    {
      "name": "Olivia Davis",
      "status": "last seen recently",
      "online": false,
      "color": Colors.indigo,
    },
  ];
});
