
import 'package:flutter/material.dart';
import 'create_game_body.dart';

class CreateGameScreen extends StatelessWidget {
  const CreateGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CreateGameBody(),
    );
  }
}
