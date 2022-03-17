import 'package:flutter/material.dart';
import './login_screen.dart';
import './signup_screen.dart';
import "../widgets/general_buttom.dart";
class WelcomeScreen extends StatelessWidget {

  static const routeName = '/welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

        

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.lightGreen,
              ],
            )
          ),
          ),

          Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 75, left: 0, right: 0),
                    ),
                    Stack(
                      children: <Widget>[
                        // background profilePic start
                        Container(
                           padding: EdgeInsets.only(top: screenHeight*0.35, left: 50, right: 50),

                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "images/build_green_logo.png",
                              ),
                            ),
                          ),
                        ),
                        // background profilePic end
                      ]
                    ),
                    const Expanded(child: Text(""),),
                    Container(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.bottomCenter,
                        child : GeneralButton(
                          title: 'Entrar', 
                          textColor: Colors.green , 
                          action: () => {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                                  return const LogInScreen();
                                  }
 
                              )
                           )
                          }
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 150),
                      alignment: Alignment.bottomCenter,
                      child : GeneralButton(
                          
                          title: 'Registrarse', 
                          textColor: Colors.lightGreen , 
                          action: () => {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                                  return const SignUpScreen();
                                  }
                              )
                           )
                          }
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],)
    );
  }
}