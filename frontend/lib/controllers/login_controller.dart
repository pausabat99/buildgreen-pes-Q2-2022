import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var _googleSignIn = GoogleSignIn();

  var googleAccount = Rx<GoogleSignInAccount?>(null);
  GoogleSignInAuthentication? ggAuth;

  login() async {
    googleAccount.value = await _googleSignIn.signIn();
    ggAuth = await googleAccount.value?.authentication;
  }
}
