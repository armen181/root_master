import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/question_controller.dart';
import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  List<String> userNameList = [
    "Saqo",
    "Suro",
    "Samo",
    "Saro",
  ];

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
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
              showModalBottomSheet(
                isScrollControlled: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "Score",
                              style: TextStyle(fontSize: 24),
                            ),
                            const Spacer(),
                            const SizedBox(width: 50)
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userNameList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text("${index + 1}", style: const TextStyle(fontSize: 24)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(Icons.person),
                                  ),
                                  Text(
                                    userNameList[index],
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    width: 100,
                                    child: const Center(
                                      child: Text("1000"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(child: Text("Quit game")),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.table_rows_rounded),
          )
        ],
      ),
      body: const Body(),
    );
  }
}
