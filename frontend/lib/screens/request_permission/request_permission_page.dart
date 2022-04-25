// ignore_for_file: import_of_legacy_library_into_null_safe

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
    return const Scaffold(
      body: SafeArea(child: SizedBox(width: double.infinity, height: double.infinity,))
      
    );
  }
}