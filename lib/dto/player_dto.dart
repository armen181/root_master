import 'package:json_annotation/json_annotation.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDto {
  String id;
  String userName;

  PlayerDto(this.id, this.userName);

  factory PlayerDto.fromJson(Map<String, dynamic> json) => _$PlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);
}
