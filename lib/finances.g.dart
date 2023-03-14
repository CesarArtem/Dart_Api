// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Finances _$$_FinancesFromJson(Map<String, dynamic> json) => _$_Finances(
      id: json['id'] as int,
      number: json['number'] as String,
      nameOperation: json['nameOperation'] as String,
      description: json['description'] as String,
      kategory: json['kategory'] as String,
      dateOperation: json['dateOperation'] as String,
      summ: json['summ'] as int,
      isdeleted: json['isdeleted'] as bool,
    );

Map<String, dynamic> _$$_FinancesToJson(_$_Finances instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'nameOperation': instance.nameOperation,
      'description': instance.description,
      'kategory': instance.kategory,
      'dateOperation': instance.dateOperation,
      'summ': instance.summ,
      'isdeleted': instance.isdeleted,
    };
