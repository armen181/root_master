import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_master/service/room_service.dart';

import '../../../constants.dart';
import '../../di/injector.dart';
import '../quiz/quiz_screen.dart';

class CreateGameBody extends StatelessWidget {
  final RoomService _roomService = injector<RoomService>();

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
              FutureBuilder(
                  future: _roomService.createRoom(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      return Text(
                        "Room Number : ${snapshot.data?.token}",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    }
                  }),
              const SizedBox(height: kDefaultPadding*2),
              Center(
                child: Text(
                  "Players",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 1))
                    .asyncMap((i) => _roomService.getPlayers()), // i is null here (check periodic docs)
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      height: 280,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
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
                                  snapshot.data![index].userName,
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
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
                    );
                  } else {
                    return Text(
                      "Waiting players to join ...",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 20),
                    );
                  };
                }, // builder should also handle the case when data is not fetched yet
              ),
              const SizedBox(height: kDefaultPadding),
              const SizedBox(height: kDefaultPadding),
              const Spacer(),
              const TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black54,
                  hintText: "Enter Your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              InkWell(
                onTap: () => Get.to(QuizScreen()),
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
