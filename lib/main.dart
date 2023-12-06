
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/pages/UserType.dart';
import 'package:merit_tuition_v1/constants/keys.dart';
import 'package:merit_tuition_v1/pages/parents_dashboard.dart';
import 'package:merit_tuition_v1/pages/teacherDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Stripe.publishableKey = keys.publishableKey;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthenticated = false;
  bool _isLoading = true;
  String userType = "";

  Future<void> _getUser(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var token = sharedPreferences.getString('token');
    userType = (sharedPreferences.getString('userType') ?? userType);

    var url = Uri.parse('http://35.176.201.155/api/profile?userType=$userType');

    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token', // Add the authorization header
      },
    );


    if (response.statusCode == 200) {
      try {
        setState(() {
          _isAuthenticated = true;
          _isLoading = false;
          FlutterNativeSplash.remove();
        });
      } catch (e) {
        print(response);
      }
      return;
    }
    else {
      setState(() {
        _isLoading = false;
        FlutterNativeSplash.remove();
      });
    }
  }

  @override
  void initState() {
    _getUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_isAuthenticated);
    return _isLoading? const Center() :MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: _isAuthenticated ? (userType == "parent" ? "/home" : "/teacher"):"/",
      routes: {
        '/': (context) => const UserType(),
        '/home': (context) => const ParentsHome(),
        '/teacher': (context) => const TeacherDashboard(),
      },
    );
  }
}
