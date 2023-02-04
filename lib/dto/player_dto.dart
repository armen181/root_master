import 'package:json_annotation/json_annotation.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDto {
  String id;
  String userName;
  PlayerState state;
  PlayerLastResult lastResult;
  int score;

  PlayerDto(this.id, this.userName, this.state, this.lastResult, this.score);

  factory PlayerDto.fromJson(Map<String, dynamic> json) => _$PlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);
}

enum PlayerState { PREPARING, READY_TO_START }

enum PlayerLastResult { SUCCEED, FAILED, NOT_ANSWERED }
