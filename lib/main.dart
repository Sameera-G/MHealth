import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nasa_tlx_eeg_research/jobtitle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Either ensure your Firebase config is automatically applied or manually initialize Firebase as shown below.
  // Manual initialization (not recommended as a first approach):
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8aREdsuV2pIv7Q_MWEOIYmEWUHEUU7HE",
      appId: "1:208462808242:web:11ca8e2a71a869e529f5ab",
      messagingSenderId: "208462808242",
      projectId: "mwl-predictor",
    ),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feedback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobTitleInputPage(),
    );
  }
}
