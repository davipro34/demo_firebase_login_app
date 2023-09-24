import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'signup_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      print('Utilisateur non connecté');
      runApp(const LoginTabBar());
    } else {
      print('Utilisateur connecté: ' +user.email!);
      runApp(const Homepage());
    }
  });
}

class LoginTabBar extends StatelessWidget {
  const LoginTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.red.shade400,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            bottom: TabBar(tabs: [Tab(text: 'Connexion'), Tab(text: 'Inscription',)]),
          title: const Text('Firebase Login'),
          ),
          body: TabBarView(
            children: [
              LoginPage(),
              SignupPage(),
            ],
          ),  
        ),
      ),
    );
  }

  void loginToFirebase() {
    try {
      auth
        .signInWithEmailAndPassword(
          email: 'david@davipro.fr',
          password: 'motdepasse')
        .then((value) {
          print(value.toString());
        });
    } catch (e) {
      print(e.toString());
    }
  }
}