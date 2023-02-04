// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerDto _$PlayerDtoFromJson(Map<String, dynamic> json) => PlayerDto(
      json['id'] as String,
      json['userName'] as String,
      $enumDecode(_$PlayerStateEnumMap, json['state']),
      $enumDecode(_$PlayerLastResultEnumMap, json['lastResult']),
      json['score'] as int,
    );

Map<String, dynamic> _$PlayerDtoToJson(PlayerDto instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'state': _$PlayerStateEnumMap[instance.state]!,
      'lastResult': _$PlayerLastResultEnumMap[instance.lastResult]!,
      'score': instance.score,
    };

const _$PlayerStateEnumMap = {
  PlayerState.PREPARING: 'PREPARING',
  PlayerState.READY_TO_START: 'READY_TO_START',
};

const _$PlayerLastResultEnumMap = {
  PlayerLastResult.SUCCEED: 'SUCCEED',
  PlayerLastResult.FAILED: 'FAILED',
  PlayerLastResult.NOT_ANSWERED: 'NOT_ANSWERED',
};
