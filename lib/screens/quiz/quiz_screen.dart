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
                backgroundColor: Colors.grey.shade800,
                isScrollControlled: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      SizedBox(
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
                      StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((i) => _roomService.getPlayers()), // i is null here (check periodic docs)
                          builder: (context, snapshot) {
                            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                              return SizedBox(
                                height: 280,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Players",
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultPadding),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                                          margin: const EdgeInsets.all(10),
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
                                                snapshot.data![index].userName,
                                              ),
                                              const Spacer(),
                                              Container(
                                                decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
                                                width: 100,
                                                child: snapshot.data![index].state == PlayerState.READY_TO_START
                                                    ? const Center(
                                                        child: Icon(
                                                        Icons.check,
                                                        size: 40,
                                                      ))
                                                    : Center(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          child: const CircularProgressIndicator(),
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                ),
                              );
                            }
                          }),
                      const Spacer(),
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              height: 70,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("Quit game")),
                            ),
                            onTap: () => Get.to(() => const WelcomeScreen()),
                          ),
                          const Spacer(),
                          InkWell(
                            child: Container(
                              height: 70,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("Close")),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
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
