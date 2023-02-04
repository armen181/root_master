import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/question_controller.dart';
import '../quiz/quiz_screen.dart';
import '../waiting/player_waiting_screen.dart';
import '../welcome/welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: Image.asset("assets/icons/4199010.jpeg", fit: BoxFit.fill)),
          Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              Text(
                "Score",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              Text(
                "TODO - list of users",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kSecondaryColor),
              ),
              const Spacer(flex: 1),
              InkWell(
                onTap: () => Get.to(const WelcomeScreen()),
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
                    "New Game",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              InkWell(
                onTap: () => Get.to(() => const PlayerWaitingScreen()),
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
                    "Play Again",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
            ],
          )
        ],
      ),
    );
  }
}
