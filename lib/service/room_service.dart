import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:root_master/dto/player_dto.dart';
import 'package:root_master/dto/room_dto.dart';

import '../constants.dart';
import '../di/injector.dart';

class RoomService {
  final Dio _httpService = injector<Dio>();

  late RoomDto roomDto;

  Future<RoomDto> createRoom() async {
    final result = await _httpService.post(
      '$baseUrl$roomUri',
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
    roomDto = RoomDto.fromJson(result.data);
    return roomDto;
  }

  Future<List<PlayerDto>> getPlayers() async {
    var formData = FormData.fromMap({
      'token': roomDto.token
    });
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
    return (result.data as List)
        .map((data) => PlayerDto.fromJson(data))
        .toList();
  }

  Future<void> startGame() async {
    await _httpService.post(
      '$baseUrl$startUri',
      options: Options(
          validateStatus: (status) {
            return status! < 400;
          },
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
    );
  }
}
