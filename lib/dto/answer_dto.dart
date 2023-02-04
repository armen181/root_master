import 'package:json_annotation/json_annotation.dart';

part 'answer_dto.g.dart';

@JsonSerializable()
class AnswerDto {
  int questionId;
  int answerIndex;
  int roomId;
  String userName;
  int time;

  AnswerDto(this.questionId, this.answerIndex, this.roomId, this.userName, this.time);

  factory AnswerDto.fromJson(Map<String, dynamic> json) => _$AnswerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);
}
