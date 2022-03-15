import 'package:flutter/material.dart';
import './login_screen.dart';
import './signup_screen.dart';

class WelcomeScreen extends StatelessWidget {

  static const routeName = '/welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);
  

  Widget authentificationButton(String title, Color textColor, BuildContext ctx, StatefulWidget screen) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
      child: ElevatedButton(
        
        style:ElevatedButton.styleFrom(
          primary: Colors.teal.withAlpha(0),
          onPrimary: Colors.white.withAlpha(0),
          shadowColor: Colors.black.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: const BorderSide(
            
            color: Colors.white,
            width: 3,
            
            ),
          elevation: 1
        ),
        onPressed: () {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
            return screen;
          }));
        },
        child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
      ),
    );
  }

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
                      padding: const EdgeInsets.only(top: 100, left: 0, right: 0),
                    ),
                    Stack(
                      children: <Widget>[
                        // background profilePic start
                        Container(
                           padding: EdgeInsets.only(top: screenHeight*0.33, left: 0, right: 0),

                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight:  Radius.circular(15),
                              topLeft:  Radius.circular(15),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                        child : authentificationButton('Sign In', Colors.green, context, const LogInScreen()),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                        child : authentificationButton('Sign Up', Colors.lightGreen, context, const SignUpScreen()),
                    ),
                     const Padding(padding:  EdgeInsets.only(top: 100),),

                  ],
                ),
              ),
            ],
          ),
        ],)
    );
  }
}