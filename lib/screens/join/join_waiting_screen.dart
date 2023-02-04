import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/screens/quiz/components/body.dart';

import '../../../controllers/question_controller.dart';
import 'join_game_body.dart';
import 'join_waiting_body.dart';

class JoinWaitingScreen extends StatelessWidget {
  const JoinWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: JoinWaitingBody(),
    );
  }
}
