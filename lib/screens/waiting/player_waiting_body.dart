import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/service/room_service.dart';

import '../../../constants.dart';
import '../../di/injector.dart';
import '../../dto/player_dto.dart';
import '../quiz/quiz_screen.dart';

class PlayerWaitingBody extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();

  PlayerWaitingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: Image.asset("assets/icons/4199010.jpeg", fit: BoxFit.fill)),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kDefaultPadding),
              Text(
                "Room Number : ${_roomService.getToken()}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((i) => _roomService.getPlayers()), // i is null here (check periodic docs)
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    if (snapshot.data!.any((pl) => pl.state == PlayerState.PREPARING)) {
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
                    }
                    return _roomService.getCountDown(context, () {
                      _roomService.setPlayerPreparing();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => QuizScreen()), (e) => false);
                    });
                  } else {
                    return Text(
                      "Waiting players to join ...",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 20),
                    );
                  }
                },
              ),
              const SizedBox(height: kDefaultPadding),
              const Spacer(),
              const SizedBox(height: kDefaultPadding),
              InkWell(
                onTap: () {
                  _roomService.setPlayerReady().then((value) => {});
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                  decoration: const BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    "Ready to Start",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
        )
      ],
    );
  }
}
