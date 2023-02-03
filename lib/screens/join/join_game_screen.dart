
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/screens/quiz/components/body.dart';

import '../../../controllers/question_controller.dart';
import 'join_game_body.dart';

class JoinGameScreen extends StatelessWidget {
  const JoinGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body: JoinGameBody(),
    );
  }
}
