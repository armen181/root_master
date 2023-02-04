// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDto _$RoomDtoFromJson(Map<String, dynamic> json) => RoomDto(
      json['token'] as int,
      (json['players'] as List<dynamic>).map((e) => PlayerDto.fromJson(e as Map<String, dynamic>)).toList(),
      (json['questions'] as List<dynamic>).map((e) => QuestionDto.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$RoomDtoToJson(RoomDto instance) => <String, dynamic>{
      'token': instance.token,
      'players': instance.players,
      'questions': instance.questions,
    };
