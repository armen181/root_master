// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
      id: json['id'] as int,
      question: json['question'] as String,
      answerIndex: json['answer_index'] as int,
      answers: (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) => <String, dynamic>{
      'id': instance.id,
      'answer_index': instance.answerIndex,
      'question': instance.question,
      'answers': instance.answers,
    };
