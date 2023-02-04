import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  final int id, answer;
  final String question;
  final List<String> options;

  QuestionDto({required this.id, required this.question, required this.answer, required this.options});

  factory QuestionDto.fromJson(Map<String, dynamic> json) => _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}
