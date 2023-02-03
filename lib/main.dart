import 'package:flutter/material.dart';
import 'package:root_master/di/registry.dart';
import 'package:root_master/pages/create_game_page.dart';
import 'package:root_master/pages/join_game_page.dart';
import 'package:root_master/pages/login_page.dart';
import 'package:root_master/pages/welcome_page.dart';

void main() async{
  configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Root Master',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Root master'),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/create': (context) => const CreateGamePage(),
        '/join': (context) => const JoinGamePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 4,),
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/create', (Route<dynamic> route) => false);
                  },
                  child: const Text('Create Game')),
            ),
            const Spacer(),
            SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Join Game'))),
            const Spacer(flex: 4,),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
