import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../di/injector.dart';
import '../../service/room_service.dart';
import '../waiting/player_waiting_screen.dart';

class JoinGameBody extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();
  final TextEditingController token = TextEditingController();
  final TextEditingController userName = TextEditingController();

  JoinGameBody({
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
                  "Join To The Game",
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
              const SizedBox(height: kDefaultPadding * 2),
              TextField(
                maxLength: 5,
                controller: token,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black54,
                  hintText: "Enter Room Number Here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _roomService.join(userName.text.toString(), int.parse(token.value.text)).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PlayerWaitingScreen()), (e) => false));
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
                    "Connect",
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
