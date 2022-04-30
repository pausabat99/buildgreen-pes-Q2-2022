// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../main.dart';

class AreaPersonalCliente extends StatefulWidget {
  const AreaPersonalCliente({Key? key}) : super(key: key);
  @override
  State<AreaPersonalCliente> createState() => _AreaPersonalCliente();
}

class _AreaPersonalCliente extends State<AreaPersonalCliente> {
  bool processing = false;
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

  Future<void> onPressedLogOut() async {
    if (processing) return;
    processing = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/logout/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            "Token " + prefs.getString("_user_token"),
      },
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const WelcomeScreen(),
      ),
      (route) => false,
    );
  }

  Widget createbox() {
    return Flexible(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10.0),
        child: const Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 94, 95, 94)),
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 50,
              top: 10,
            ),
            child: Text(
              AppLocalizations.of(context)!.areapersonal,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  left: 50,
                  top: 100,
                ),
              ),
              createbox(),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
              createbox(),
              const Padding(
                padding: EdgeInsets.only(
                  right: 50,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 50,
              top: 10,
            ),
            child: Text(
              AppLocalizations.of(context)!.preciosatiemporeal,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 50,
                    top: 40,
                    right: 50,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .verpreciosatiemporeal,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Image(
                        image: AssetImage("assets/images/euro.png"),
                        height: 50,
                        width: 50,
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 94, 95, 94)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 50,
              top: 40,
            ),
            child: Text(
              AppLocalizations.of(context)!.consumoenergetico,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            height: 200.0,
            margin: const EdgeInsets.only(
              left: 50,
              top: 40,
              right: 50,
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Image(
              fit: BoxFit.fill,
              image: AssetImage(
                  "assets/images/cual_es_el_gasto_en_electricidad2.png"),
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 40,
              right: 20,
            ),
            child: GeneralButton(
              title: "Acceder al Perfil",
              action: onPressedLogOut,
              textColor: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
              bottom: 20,
            ),
            child: GeneralButton(
              title: "Cerrar Session",
              action: onPressedLogOut,
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
