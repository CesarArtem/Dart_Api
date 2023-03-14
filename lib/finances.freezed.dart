// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finances.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Finances _$FinancesFromJson(Map<String, dynamic> json) {
  return _Finances.fromJson(json);
}

/// @nodoc
mixin _$Finances {
  int get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get nameOperation => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get kategory => throw _privateConstructorUsedError;
  String get dateOperation => throw _privateConstructorUsedError;
  int get summ => throw _privateConstructorUsedError;
  bool get isdeleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinancesCopyWith<Finances> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancesCopyWith<$Res> {
  factory $FinancesCopyWith(Finances value, $Res Function(Finances) then) =
      _$FinancesCopyWithImpl<$Res, Finances>;
  @useResult
  $Res call(
      {int id,
      String number,
      String nameOperation,
      String description,
      String kategory,
      String dateOperation,
      int summ,
      bool isdeleted});
}

/// @nodoc
class _$FinancesCopyWithImpl<$Res, $Val extends Finances>
    implements $FinancesCopyWith<$Res> {
  _$FinancesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? nameOperation = null,
    Object? description = null,
    Object? kategory = null,
    Object? dateOperation = null,
    Object? summ = null,
    Object? isdeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      nameOperation: null == nameOperation
          ? _value.nameOperation
          : nameOperation // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      kategory: null == kategory
          ? _value.kategory
          : kategory // ignore: cast_nullable_to_non_nullable
              as String,
      dateOperation: null == dateOperation
          ? _value.dateOperation
          : dateOperation // ignore: cast_nullable_to_non_nullable
              as String,
      summ: null == summ
          ? _value.summ
          : summ // ignore: cast_nullable_to_non_nullable
              as int,
      isdeleted: null == isdeleted
          ? _value.isdeleted
          : isdeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FinancesCopyWith<$Res> implements $FinancesCopyWith<$Res> {
  factory _$$_FinancesCopyWith(
          _$_Finances value, $Res Function(_$_Finances) then) =
      __$$_FinancesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String number,
      String nameOperation,
      String description,
      String kategory,
      String dateOperation,
      int summ,
      bool isdeleted});
}

/// @nodoc
class __$$_FinancesCopyWithImpl<$Res>
    extends _$FinancesCopyWithImpl<$Res, _$_Finances>
    implements _$$_FinancesCopyWith<$Res> {
  __$$_FinancesCopyWithImpl(
      _$_Finances _value, $Res Function(_$_Finances) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? nameOperation = null,
    Object? description = null,
    Object? kategory = null,
    Object? dateOperation = null,
    Object? summ = null,
    Object? isdeleted = null,
  }) {
    return _then(_$_Finances(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      nameOperation: null == nameOperation
          ? _value.nameOperation
          : nameOperation // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      kategory: null == kategory
          ? _value.kategory
          : kategory // ignore: cast_nullable_to_non_nullable
              as String,
      dateOperation: null == dateOperation
          ? _value.dateOperation
          : dateOperation // ignore: cast_nullable_to_non_nullable
              as String,
      summ: null == summ
          ? _value.summ
          : summ // ignore: cast_nullable_to_non_nullable
              as int,
      isdeleted: null == isdeleted
          ? _value.isdeleted
          : isdeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Finances implements _Finances {
  const _$_Finances(
      {required this.id,
      required this.number,
      required this.nameOperation,
      required this.description,
      required this.kategory,
      required this.dateOperation,
      required this.summ,
      required this.isdeleted});

  factory _$_Finances.fromJson(Map<String, dynamic> json) =>
      _$$_FinancesFromJson(json);

  @override
  final int id;
  @override
  final String number;
  @override
  final String nameOperation;
  @override
  final String description;
  @override
  final String kategory;
  @override
  final String dateOperation;
  @override
  final int summ;
  @override
  final bool isdeleted;

  @override
  String toString() {
    return 'Finances(id: $id, number: $number, nameOperation: $nameOperation, description: $description, kategory: $kategory, dateOperation: $dateOperation, summ: $summ, isdeleted: $isdeleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Finances &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.nameOperation, nameOperation) ||
                other.nameOperation == nameOperation) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.kategory, kategory) ||
                other.kategory == kategory) &&
            (identical(other.dateOperation, dateOperation) ||
                other.dateOperation == dateOperation) &&
            (identical(other.summ, summ) || other.summ == summ) &&
            (identical(other.isdeleted, isdeleted) ||
                other.isdeleted == isdeleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, number, nameOperation,
      description, kategory, dateOperation, summ, isdeleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FinancesCopyWith<_$_Finances> get copyWith =>
      __$$_FinancesCopyWithImpl<_$_Finances>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FinancesToJson(
      this,
    );
  }
}

abstract class _Finances implements Finances {
  const factory _Finances(
      {required final int id,
      required final String number,
      required final String nameOperation,
      required final String description,
      required final String kategory,
      required final String dateOperation,
      required final int summ,
      required final bool isdeleted}) = _$_Finances;

  factory _Finances.fromJson(Map<String, dynamic> json) = _$_Finances.fromJson;

  @override
  int get id;
  @override
  String get number;
  @override
  String get nameOperation;
  @override
  String get description;
  @override
  String get kategory;
  @override
  String get dateOperation;
  @override
  int get summ;
  @override
  bool get isdeleted;
  @override
  @JsonKey(ignore: true)
  _$$_FinancesCopyWith<_$_Finances> get copyWith =>
      throw _privateConstructorUsedError;
}
