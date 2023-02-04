// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerDto _$AnswerDtoFromJson(Map<String, dynamic> json) => AnswerDto(
      json['questionId'] as int,
      json['answerIndex'] as int,
      json['roomId'] as int,
      json['userName'] as String,
      json['time'] as int,
    );

Map<String, dynamic> _$AnswerDtoToJson(AnswerDto instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'answerIndex': instance.answerIndex,
      'roomId': instance.roomId,
      'userName': instance.userName,
      'time': instance.time,
    };
