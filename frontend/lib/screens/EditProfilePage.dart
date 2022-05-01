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
import '../widgets/TextFieldProfileWidget.dart';
import '../widgets/back_button.dart';
import 'area_personal_cliente.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/user";

  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class User {
  User({
    this.id = "",
    this.username = "",
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

class _EditProfilePageState extends State<EditProfilePage> {
  late Locale lang = Localizations.localeOf(context);

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
              child: Text(
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
            Text(
              'Idioma',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            DropdownButton<Locale>(
                isExpanded: true,
                value: lang,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Username',
              text: 'Danifb',
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: 'dani@gmail.com',
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Direccion',
              text: 'Calle Falsa 123',
              maxLines: 5,
              onChanged: (about) {},
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 40,
                right: 20,
              ),
              child: GeneralButton(
                title: "Guardar",
                action: onPressedUpdateProfile,
                textColor: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
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
