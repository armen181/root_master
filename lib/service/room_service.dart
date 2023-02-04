import 'dart:io';

import 'package:dio/dio.dart';
import 'package:root_master/dto/player_dto.dart';
import 'package:root_master/dto/room_dto.dart';

import '../constants.dart';
import '../di/injector.dart';

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

  int getToken() {
    return _token;
  }
}
