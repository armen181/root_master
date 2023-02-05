import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/question_controller.dart';
import '../../di/injector.dart';
import '../../dto/player_dto.dart';
import '../../service/room_service.dart';
import '../quiz/quiz_screen.dart';
import '../waiting/player_waiting_screen.dart';
import '../welcome/welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();

  ResultScreen({super.key});

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
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((i) => _roomService.getPlayers()),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    snapshot.data!.sort((a, b) => b.score.compareTo(a.score));
                    return Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Winner is ${snapshot.data!.first.userName}",
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: kSecondaryColor),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(color: snapshot.data![index].lastResult == PlayerLastResult.SUCCEED ? Colors.lightGreen.withOpacity(0.3) : Colors.redAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
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
                                      decoration: BoxDecoration(color: snapshot.data![index].lastResult == PlayerLastResult.SUCCEED ? Colors.lightGreen.withOpacity(0.35) : Colors.redAccent.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
                                      width: 100,
                                      child: Center(child: Text(snapshot.data![index].score.toString(), style: const TextStyle(color: Colors.white, fontSize: 24))),
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
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const Spacer(flex: 1),
              InkWell(
                onTap: () {
                  Get.delete<QuestionController>();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()), (e) => false);
                },
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
                onTap: () {
                  Get.delete<QuestionController>();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PlayerWaitingScreen()), (e) => false);
                },
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
