
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/screens/quiz/components/body.dart';

import '../../../controllers/question_controller.dart';
import 'create_game_body.dart';

class CreateGameScreen extends StatelessWidget {
  const CreateGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body: CreateGameBody(),
    );
  }
}
