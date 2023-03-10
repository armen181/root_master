import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/question_controller.dart';
import '../../../dto/question_dto.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question});

  final QuestionDto question;

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController(context));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question.question,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const Spacer(),
          ...List.generate(
            4,
            (index) => Option(
              index: index,
              text: question.answers[index],
              press: () => controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
