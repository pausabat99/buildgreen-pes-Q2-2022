// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:buildgreen/constants.dart' as Constants;

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
      Uri.parse(Constants.API_ROUTE+'/logout/'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.areapersonal,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50,
                    ),
                    child: Text(
                      'Carrer de Rosello, 1\n08029 Barcelona',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 190.0,
                      height: 190.0,
                      margin: const EdgeInsets.all(50.0),
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
                  ),
                  Container(
                    width: 190.0,
                    height: 190.0,
                    margin: const EdgeInsets.all(50.0),
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.preciosatiemporeal,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 70.0,
                    margin: const EdgeInsets.all(50.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image(
                              image: AssetImage("assets/images/euro.png"),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .verpreciosatiemporeal,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 94, 95, 94)),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.consumoenergetico,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 400.0,
                      margin: const EdgeInsets.all(50.0),
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
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 50,
                      ), // use Spacer
                    ),
                  ]),
            ],
          ),
          DropdownButton<Locale>(
              value: lang,
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
          GeneralButton(
            title: "Log out",
            action: onPressedLogOut,
            textColor: Colors.black,
          ),
          const Padding(padding: EdgeInsets.only(top: 20))
        ],
      ),
    );
  }
}
