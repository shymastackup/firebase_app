// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:backend_project/providers/auth_provider.dart';
// import 'package:backend_project/screens/homepage.dart';
// import 'package:backend_project/login_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(
// MultiProvider(
//   providers: [
//     ChangeNotifierProvider(create: (context) => AuthProvider()),
//     StreamProvider<User?>(
//       create: (context) => FirebaseAuth.instance.authStateChanges(),
//       initialData: null,
//     ),
//   ],
//   child: const MyApp(),
// )

//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User?>(context);

//     return MaterialApp(
//       title: 'Flutter Firebase Auth',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/login': (context) =>  LoginPage(),
//         '/home': (context) => const HomePage(),
//       },
//       home: user == null ? LoginPage() : const HomePage(),
//     );
//   }
// }


import 'package:backend_project/screens/home_pge.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) =>  const HomePage(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return  const HomePage(); 
          }
          return LoginPage(); 
        },
      ),
    );
  }
}