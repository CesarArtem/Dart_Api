import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'finances.freezed.dart';
part 'finances.g.dart';

@freezed
class Finances with _$Finances{
  const factory Finances({
    required int id,
    required String number,
    required String nameOperation,
    required String description,
    required String kategory,
    required String dateOperation,
    required int summ,
    required bool isdeleted,
  })= _Finances;

  factory Finances.fromJson(Map<String, dynamic> json)=> _$FinancesFromJson(json);
}