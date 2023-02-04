import 'package:json_annotation/json_annotation.dart';
import 'package:root_master/dto/player_dto.dart';
import 'package:root_master/dto/question_dto.dart';

part 'room_dto.g.dart';

@JsonSerializable()
class RoomDto {
  int token;
  List<PlayerDto> players;
  List<QuestionDto> questions;

  RoomDto(this.token, this.players, this.questions);

  factory RoomDto.fromJson(Map<String, dynamic> json) => _$RoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);
}
