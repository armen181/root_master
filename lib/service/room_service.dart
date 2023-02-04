import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:root_master/dto/answer_dto.dart';
import 'package:root_master/dto/player_dto.dart';
import 'package:root_master/dto/room_dto.dart';

import '../constants.dart';
import '../di/injector.dart';
import '../dto/question_dto.dart';
import '../screens/welcome/welcome_screen.dart';

class RoomService {
  final Dio _httpService = injector<Dio>();
  late int _token;
  late PlayerDto _user;
  late RoomDto _roomDto;

  Future<RoomDto> createRoom(String userName) async {
    var formData = FormData.fromMap({
      'userName': userName,
    });
    final result = await _httpService.post(
      '$baseUrl$roomUri',
      data: formData,
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
    _roomDto = RoomDto.fromJson(result.data);
    _token = _roomDto.token;
    _user = _roomDto.players.first;
    return _roomDto;
  }

  Future<List<PlayerDto>> getPlayers() async {
    var formData = FormData.fromMap({'token': _token});
    final result = await _httpService.post(
      '$baseUrl$playerUri',
      data: formData,
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
    return (result.data as List).map((data) => PlayerDto.fromJson(data)).toList();
  }

  Future<void> setPlayerState(PlayerState state) async {
    var formData = FormData.fromMap({'token': _token, 'id': _user.id, 'state': state.name});
    await _httpService.post(
      '$baseUrl$playerStateUri',
      data: formData,
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
  }

  Future<void> join(String userName, int joinToken) async {
    _token = joinToken;
    var formData = FormData.fromMap({
      'token': _token,
      'userName': userName,
    });
    final result = await _httpService.post(
      '$baseUrl$joinUri',
      data: formData,
      options: Options(
          validateStatus: (status) {
            return status == 200;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
    _user = PlayerDto.fromJson(result.data);
  }

  Future<void> answer(int questionId, int answerIndex, int time) async {
    await _httpService.post(
      '$baseUrl$answerUri',
      data: AnswerDto(questionId, answerIndex, _token, _user.userName, time),
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
  }

  int getToken() {
    return _token;
  }

  int getQuestionId(int index) {
    return _roomDto.questions[index - 1].id;
  }

  List<QuestionDto> getQuestions() {
    return _roomDto.questions;
  }

  Future<dynamic> getShowModal(BuildContext context, VoidCallback onPlayersReady) {
    bool readyToStart = false;
    return showModalBottomSheet(
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
                stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((i) => getPlayers()), // i is null here (check periodic docs)
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    if (snapshot.data!.any((pl) => pl.state == PlayerState.PREPARING)) {
                      snapshot.data!.sort((a, b) => a.score.compareTo(b.score));
                      readyToStart = snapshot.data!.where((element) => element.userName == _user.userName).first.state == PlayerState.READY_TO_START;
                      return Expanded(
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
                                        child: Text("${snapshot.data![index].score} ", style: const TextStyle(fontSize: 24)),
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
                                      color: readyToStart ? Colors.lightGreen.withOpacity(0.35) : Colors.blueGrey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(child: Text("Ready")),
                                  ),
                                  onTap: () {
                                    setPlayerState(PlayerState.READY_TO_START);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    } else {
                      return getCountDown(context, onPlayersReady);
                    }
                  } else {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ],
        );
      },
    );
  }

  Widget getCountDown(BuildContext context, VoidCallback onFinish) {
    return Center(
      child: CircularCountDownTimer(
        duration: 5,
        initialDuration: 0,
        controller: CountDownController(),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        ringColor: Colors.grey[300]!,
        ringGradient: null,
        fillColor: Colors.green[500]!,
        fillGradient: null,
        backgroundColor: Colors.green[300],
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: onFinish,
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            return "Start";
          } else {
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
