import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/screens/quiz/components/body.dart';

import '../../../controllers/question_controller.dart';
import 'join_game_body.dart';
import 'player_waiting_body.dart';

class PlayerWaitingScreen extends StatelessWidget {
  const PlayerWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: JoinWaitingBody(),
    );
  }
}
