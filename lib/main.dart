import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:icons_plus/icons_plus.dart';
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
              LoginPage(),
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

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber.shade300,
            Colors.amber.shade700,
            Colors.orange.shade900,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            flutterIcon,
            //titleSection,
            //textSection,
            //InputSection(),
            //forgetButton,
          ],
        ),
      ),
    );
  }
}

Widget flutterIcon = Container(
  margin: const EdgeInsets.only(top: 20),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60),
    color: const Color.fromRGBO(255, 255, 255, 0.1),
  ),
  height: 200,
  width: 200,
  child: Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 15,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Logo(Logos.firebase),

  ),
);