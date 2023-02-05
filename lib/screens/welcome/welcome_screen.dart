import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../create/create_game_screen.dart';
import '../join/join_game_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: Image.asset("assets/icons/4199010.jpeg", fit: BoxFit.fill)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2), //2/6
                  Text(
                    "Let's Play Root Master,",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text("Be fast to win"),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CreateGameScreen()), (e) => false);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                      // 15
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Create Game",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ), // 1/6
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const JoinGameScreen()), (e) => false);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                      // 15
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Join Game",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
