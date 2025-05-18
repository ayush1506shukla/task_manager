<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        return user.uid;
      } else {
        return "None";
      }
    } catch (e) {
      print(e.toString());
      return "None";
    }
  }

  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        return user.uid;
      } else {
        return "None";
      }
    } catch (e) {
      print(e.toString());
      return "None";
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> checkUserIsLogged() async {
    var user = _firebaseAuth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return "None";
    }
  }
}
=======
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        return user.uid;
      } else {
        return "None";
      }
    } catch (e) {
      print(e.toString());
      return "None";
    }
  }

  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      var user = userCredential.user;

      if (user != null) {
        return user.uid;
      } else {
        return "None";
      }
    } catch (e) {
      print(e.toString());
      return "None";
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> checkUserIsLogged() async {
    var user = _firebaseAuth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return "None";
    }
  }
  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true; // Email sent successfully
    } catch (e) {
      print(e.toString());
      return false; // Failed to send email
    }
  }

  // Method to change password
  Future<bool> changePassword(String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        return true; // Password updated successfully
      }
      return false; // No user logged in
    } catch (e) {
      print(e.toString());
      return false; // Failed to update password
    }
  }
  
}
>>>>>>> b42ce23 (Intial Commit)
