import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/service/room_service.dart';

import '../../../constants.dart';
import '../../di/injector.dart';
import '../join/player_waiting_screen.dart';
import '../quiz/quiz_screen.dart';

class CreateGameBody extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();
  final TextEditingController userName = TextEditingController();

  CreateGameBody({
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
              Center(
                child: Text(
                  "Create Game",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              TextField(
                controller: userName,
                maxLength: 10,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black54,
                  hintText: "Enter Your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _roomService.createRoom(userName.text.toString()).then((value) => Get.to(const PlayerWaitingScreen()));
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
                    "Start Game",
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
