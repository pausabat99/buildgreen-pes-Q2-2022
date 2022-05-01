import 'dart:convert';
import 'dart:io';

import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../main.dart';
import '../widgets/ProfileImageWidget.dart';
import '../widgets/back_button.dart';
import '../widgets/input_form.dart';
import 'area_personal_cliente.dart';
import 'package:buildgreen/constants.dart' as Constants;

class EditProfilePage extends StatefulWidget {
  static const route = "/edit_profile";

  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class User {
  User({
    this.id = "",
    this.username = "hey",
    this.email = "",
    this.is_admin = false,
    this.license_num = "",
  });
  String id;
  String username;
  String email;
  bool is_admin;
  String license_num;
}

Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(Constants.API_ROUTE + '/user/'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader:
          "Token " + prefs.getString("_user_token"),
    },
  );

  final responseJson = jsonDecode(response.body);
  User us = User();
  us.id = responseJson['user_info']["id"].toString();
  us.username = responseJson['user_info']["username"].toString();
  us.email = responseJson['user_info']["email"].toString();
  us.is_admin = responseJson['user_info']["is_admin"] as bool;
  us.license_num = responseJson['user_info']["license_num"].toString();
  debugPrint('1' + us.username);

  return us;
}

class _EditProfilePage extends State<EditProfilePage> {
  late Locale lang = Localizations.localeOf(context);
  User _u = User();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  TextEditingController directionController = TextEditingController();

  _EditProfilePage() {
    getUser().then((val) => setState(() {
          _u = val;
          nameController.text = _u.username;
          mailController.text = _u.email;
          directionController.text = "Calle Falsa 123";
        }));
  }

  _title(String val) {
    switch (val) {
      case 'ca':
        return const Text(
          'Catala',
          style: TextStyle(fontSize: 16.0),
        );

      case 'es':
        return const Text(
          'Castellano',
          style: TextStyle(fontSize: 16.0),
        );

      default:
        return const Text(
          'Castellano',
          style: TextStyle(fontSize: 16.0),
        );
    }
  }

  Future<void> onPressedUpdateProfile() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AreaPersonalCliente(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 50),
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: const CustomBackButton(
                buttonColor: Colors.black,
              ),
            ),

            /// TITLE
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 30,
              ),
              child: const Text(
                'Perfil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),

            ProfileWidget(
              imagePath:
                  'https://marvin.com.mx/wp-content/uploads/2020/01/hide-the-pain-harold-meme-decada-encuesta-imgur-2020.jpg',
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            const Text(
              "Idioma",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            DropdownButton<Locale>(
                isExpanded: true,
                value: lang,
                style: const TextStyle(color: Colors.white),
                underline: Container(height: 2, color: Colors.white),
                onChanged: (Locale? val) {
                  MyApp.of(context)?.setLocale(val!);
                  lang = val!;
                },
                items: const [
                  Locale('es', 'ES'),
                  Locale('ca', 'CAT'),
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: _title(e.languageCode),
                        ))
                    .toList()),
            const SizedBox(height: 15),
            const Text(
              "Nombre",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            InputForm(
              controller: nameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                //_usernameCorrect = true;
              },
              validationFunction: (value) {},
            ),
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            InputForm(
              controller: mailController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                //_usernameCorrect = true;
              },
              validationFunction: (value) {},
            ),
            const Text(
              "Direccion",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            InputForm(
              controller: directionController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                //_usernameCorrect = true;
              },
              validationFunction: (value) {},
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
              ),
              child: GeneralButton(
                title: "Guardar",
                action: onPressedUpdateProfile,
                textColor: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightGreen,
          ],
        )),
      ),
    );
  }
}
