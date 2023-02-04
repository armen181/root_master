import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  final int id;
  @JsonKey(name: "answer_index")
  final int answerIndex;
  final String question;
  final List<String> answers;

  QuestionDto({required this.id, required this.question, required this.answerIndex, required this.answers});

  factory QuestionDto.fromJson(Map<String, dynamic> json) => _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}
