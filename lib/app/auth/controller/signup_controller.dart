import 'package:s_medi/general/consts/consts.dart';
import 'dart:developer';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;
  var isLoading = false.obs;

  signupUser(context) async {
    try {
      isLoading(true);
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential != null) {
        await storeUserData(
          userCredential!.user!.uid,
          nameController.text,
          passwordController.text,
          emailController.text,
        );
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);

      // Check the type of exception and show a toast accordingly
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // The email address is already in use by another account
          Get.snackbar(
            "Allready have an account",
            "If you don't remember your password you can try forget password",
            snackPosition: SnackPosition.TOP,
          );
        } else {
          // Handle other FirebaseAuth exceptions
          Get.snackbar(
            "No internet connection",
            "Please check your internet",
          );
        }
      } else {
        // Handle other exceptions (not related to FirebaseAuth)
        Get.snackbar("Try after sometime", "$e");
      }

      log("$e");
    }
  }

  storeUserData(
      String uid, String fullname, String email, String password) async {
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store
        .set({'fullname': fullname, 'email': email, 'password': password});
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}