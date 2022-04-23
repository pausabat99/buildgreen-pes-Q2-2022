import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import "package:flutter/material.dart";

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({ Key? key }) : super(key: key);

  @override
  State<RequestPermissionPage> createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(width: double.infinity, height: double.infinity,))
      
    );
  }
}