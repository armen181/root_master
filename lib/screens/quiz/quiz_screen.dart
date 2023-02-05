import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/question_controller.dart';
import '../../di/injector.dart';
import '../../dto/player_dto.dart';
import '../../service/room_service.dart';
import '../welcome/welcome_screen.dart';
import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();
  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.delete<QuestionController>();
    QuestionController questionController = Get.put(QuestionController(context));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
          () => Text.rich(
            TextSpan(
              text: "Question ${questionController.questionNumber.value}",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kSecondaryColor),
              children: [
                TextSpan(
                  text: "/${questionController.questions.length}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: kSecondaryColor),
                ),
              ],
            ),
          ),
        ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: [
          IconButton(
            onPressed: () {
              _roomService.getShowModal(context, () {});
            },
            icon: const Icon(Icons.table_rows_rounded),
          )
        ],
      ),
      body: const Body(),
    );
  }
}
