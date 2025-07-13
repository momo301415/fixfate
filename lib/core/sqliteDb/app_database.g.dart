// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StepDataTable extends StepData
    with TableInfo<$StepDataTable, StepDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeStampMeta =
      const VerificationMeta('endTimeStamp');
  @override
  late final GeneratedColumn<int> endTimeStamp = GeneratedColumn<int>(
      'end_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
      'step', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _distanceMeta =
      const VerificationMeta('distance');
  @override
  late final GeneratedColumn<int> distance = GeneratedColumn<int>(
      'distance', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        startTimeStamp,
        endTimeStamp,
        step,
        distance,
        calories,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_data';
  @override
  VerificationContext validateIntegrity(Insertable<StepDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('end_time_stamp')) {
      context.handle(
          _endTimeStampMeta,
          endTimeStamp.isAcceptableOrUnknown(
              data['end_time_stamp']!, _endTimeStampMeta));
    } else if (isInserting) {
      context.missing(_endTimeStampMeta);
    }
    if (data.containsKey('step')) {
      context.handle(
          _stepMeta, step.isAcceptableOrUnknown(data['step']!, _stepMeta));
    } else if (isInserting) {
      context.missing(_stepMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  StepDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      endTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time_stamp'])!,
      step: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step'])!,
      distance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}distance'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $StepDataTable createAlias(String alias) {
    return $StepDataTable(attachedDatabase, alias);
  }
}

class StepDataData extends DataClass implements Insertable<StepDataData> {
  final String userId;
  final int startTimeStamp;
  final int endTimeStamp;
  final int step;
  final int distance;
  final int calories;
  final bool isSynced;
  const StepDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.endTimeStamp,
      required this.step,
      required this.distance,
      required this.calories,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['end_time_stamp'] = Variable<int>(endTimeStamp);
    map['step'] = Variable<int>(step);
    map['distance'] = Variable<int>(distance);
    map['calories'] = Variable<int>(calories);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  StepDataCompanion toCompanion(bool nullToAbsent) {
    return StepDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      endTimeStamp: Value(endTimeStamp),
      step: Value(step),
      distance: Value(distance),
      calories: Value(calories),
      isSynced: Value(isSynced),
    );
  }

  factory StepDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      endTimeStamp: serializer.fromJson<int>(json['endTimeStamp']),
      step: serializer.fromJson<int>(json['step']),
      distance: serializer.fromJson<int>(json['distance']),
      calories: serializer.fromJson<int>(json['calories']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'endTimeStamp': serializer.toJson<int>(endTimeStamp),
      'step': serializer.toJson<int>(step),
      'distance': serializer.toJson<int>(distance),
      'calories': serializer.toJson<int>(calories),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  StepDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? endTimeStamp,
          int? step,
          int? distance,
          int? calories,
          bool? isSynced}) =>
      StepDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        endTimeStamp: endTimeStamp ?? this.endTimeStamp,
        step: step ?? this.step,
        distance: distance ?? this.distance,
        calories: calories ?? this.calories,
        isSynced: isSynced ?? this.isSynced,
      );
  StepDataData copyWithCompanion(StepDataCompanion data) {
    return StepDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      endTimeStamp: data.endTimeStamp.present
          ? data.endTimeStamp.value
          : this.endTimeStamp,
      step: data.step.present ? data.step.value : this.step,
      distance: data.distance.present ? data.distance.value : this.distance,
      calories: data.calories.present ? data.calories.value : this.calories,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('endTimeStamp: $endTimeStamp, ')
          ..write('step: $step, ')
          ..write('distance: $distance, ')
          ..write('calories: $calories, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId, startTimeStamp, endTimeStamp, step, distance, calories, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.endTimeStamp == this.endTimeStamp &&
          other.step == this.step &&
          other.distance == this.distance &&
          other.calories == this.calories &&
          other.isSynced == this.isSynced);
}

class StepDataCompanion extends UpdateCompanion<StepDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> endTimeStamp;
  final Value<int> step;
  final Value<int> distance;
  final Value<int> calories;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const StepDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.endTimeStamp = const Value.absent(),
    this.step = const Value.absent(),
    this.distance = const Value.absent(),
    this.calories = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StepDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int endTimeStamp,
    required int step,
    required int distance,
    required int calories,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        endTimeStamp = Value(endTimeStamp),
        step = Value(step),
        distance = Value(distance),
        calories = Value(calories);
  static Insertable<StepDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? endTimeStamp,
    Expression<int>? step,
    Expression<int>? distance,
    Expression<int>? calories,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (endTimeStamp != null) 'end_time_stamp': endTimeStamp,
      if (step != null) 'step': step,
      if (distance != null) 'distance': distance,
      if (calories != null) 'calories': calories,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StepDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? endTimeStamp,
      Value<int>? step,
      Value<int>? distance,
      Value<int>? calories,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return StepDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      endTimeStamp: endTimeStamp ?? this.endTimeStamp,
      step: step ?? this.step,
      distance: distance ?? this.distance,
      calories: calories ?? this.calories,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (endTimeStamp.present) {
      map['end_time_stamp'] = Variable<int>(endTimeStamp.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (distance.present) {
      map['distance'] = Variable<int>(distance.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('endTimeStamp: $endTimeStamp, ')
          ..write('step: $step, ')
          ..write('distance: $distance, ')
          ..write('calories: $calories, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepDataTable extends SleepData
    with TableInfo<$SleepDataTable, SleepDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeStampMeta =
      const VerificationMeta('endTimeStamp');
  @override
  late final GeneratedColumn<int> endTimeStamp = GeneratedColumn<int>(
      'end_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deepSleepSecondsMeta =
      const VerificationMeta('deepSleepSeconds');
  @override
  late final GeneratedColumn<int> deepSleepSeconds = GeneratedColumn<int>(
      'deep_sleep_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lightSleepSecondsMeta =
      const VerificationMeta('lightSleepSeconds');
  @override
  late final GeneratedColumn<int> lightSleepSeconds = GeneratedColumn<int>(
      'light_sleep_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remSleepSecondsMeta =
      const VerificationMeta('remSleepSeconds');
  @override
  late final GeneratedColumn<int> remSleepSeconds = GeneratedColumn<int>(
      'rem_sleep_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isNewSleepProtocolMeta =
      const VerificationMeta('isNewSleepProtocol');
  @override
  late final GeneratedColumn<bool> isNewSleepProtocol = GeneratedColumn<bool>(
      'is_new_sleep_protocol', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_new_sleep_protocol" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        startTimeStamp,
        endTimeStamp,
        deepSleepSeconds,
        lightSleepSeconds,
        remSleepSeconds,
        isNewSleepProtocol,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_data';
  @override
  VerificationContext validateIntegrity(Insertable<SleepDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('end_time_stamp')) {
      context.handle(
          _endTimeStampMeta,
          endTimeStamp.isAcceptableOrUnknown(
              data['end_time_stamp']!, _endTimeStampMeta));
    } else if (isInserting) {
      context.missing(_endTimeStampMeta);
    }
    if (data.containsKey('deep_sleep_seconds')) {
      context.handle(
          _deepSleepSecondsMeta,
          deepSleepSeconds.isAcceptableOrUnknown(
              data['deep_sleep_seconds']!, _deepSleepSecondsMeta));
    } else if (isInserting) {
      context.missing(_deepSleepSecondsMeta);
    }
    if (data.containsKey('light_sleep_seconds')) {
      context.handle(
          _lightSleepSecondsMeta,
          lightSleepSeconds.isAcceptableOrUnknown(
              data['light_sleep_seconds']!, _lightSleepSecondsMeta));
    } else if (isInserting) {
      context.missing(_lightSleepSecondsMeta);
    }
    if (data.containsKey('rem_sleep_seconds')) {
      context.handle(
          _remSleepSecondsMeta,
          remSleepSeconds.isAcceptableOrUnknown(
              data['rem_sleep_seconds']!, _remSleepSecondsMeta));
    } else if (isInserting) {
      context.missing(_remSleepSecondsMeta);
    }
    if (data.containsKey('is_new_sleep_protocol')) {
      context.handle(
          _isNewSleepProtocolMeta,
          isNewSleepProtocol.isAcceptableOrUnknown(
              data['is_new_sleep_protocol']!, _isNewSleepProtocolMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  SleepDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      endTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time_stamp'])!,
      deepSleepSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}deep_sleep_seconds'])!,
      lightSleepSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}light_sleep_seconds'])!,
      remSleepSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rem_sleep_seconds'])!,
      isNewSleepProtocol: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_new_sleep_protocol'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $SleepDataTable createAlias(String alias) {
    return $SleepDataTable(attachedDatabase, alias);
  }
}

class SleepDataData extends DataClass implements Insertable<SleepDataData> {
  final String userId;
  final int startTimeStamp;
  final int endTimeStamp;
  final int deepSleepSeconds;
  final int lightSleepSeconds;
  final int remSleepSeconds;
  final bool isNewSleepProtocol;
  final bool isSynced;
  const SleepDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.endTimeStamp,
      required this.deepSleepSeconds,
      required this.lightSleepSeconds,
      required this.remSleepSeconds,
      required this.isNewSleepProtocol,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['end_time_stamp'] = Variable<int>(endTimeStamp);
    map['deep_sleep_seconds'] = Variable<int>(deepSleepSeconds);
    map['light_sleep_seconds'] = Variable<int>(lightSleepSeconds);
    map['rem_sleep_seconds'] = Variable<int>(remSleepSeconds);
    map['is_new_sleep_protocol'] = Variable<bool>(isNewSleepProtocol);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SleepDataCompanion toCompanion(bool nullToAbsent) {
    return SleepDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      endTimeStamp: Value(endTimeStamp),
      deepSleepSeconds: Value(deepSleepSeconds),
      lightSleepSeconds: Value(lightSleepSeconds),
      remSleepSeconds: Value(remSleepSeconds),
      isNewSleepProtocol: Value(isNewSleepProtocol),
      isSynced: Value(isSynced),
    );
  }

  factory SleepDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      endTimeStamp: serializer.fromJson<int>(json['endTimeStamp']),
      deepSleepSeconds: serializer.fromJson<int>(json['deepSleepSeconds']),
      lightSleepSeconds: serializer.fromJson<int>(json['lightSleepSeconds']),
      remSleepSeconds: serializer.fromJson<int>(json['remSleepSeconds']),
      isNewSleepProtocol: serializer.fromJson<bool>(json['isNewSleepProtocol']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'endTimeStamp': serializer.toJson<int>(endTimeStamp),
      'deepSleepSeconds': serializer.toJson<int>(deepSleepSeconds),
      'lightSleepSeconds': serializer.toJson<int>(lightSleepSeconds),
      'remSleepSeconds': serializer.toJson<int>(remSleepSeconds),
      'isNewSleepProtocol': serializer.toJson<bool>(isNewSleepProtocol),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SleepDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? endTimeStamp,
          int? deepSleepSeconds,
          int? lightSleepSeconds,
          int? remSleepSeconds,
          bool? isNewSleepProtocol,
          bool? isSynced}) =>
      SleepDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        endTimeStamp: endTimeStamp ?? this.endTimeStamp,
        deepSleepSeconds: deepSleepSeconds ?? this.deepSleepSeconds,
        lightSleepSeconds: lightSleepSeconds ?? this.lightSleepSeconds,
        remSleepSeconds: remSleepSeconds ?? this.remSleepSeconds,
        isNewSleepProtocol: isNewSleepProtocol ?? this.isNewSleepProtocol,
        isSynced: isSynced ?? this.isSynced,
      );
  SleepDataData copyWithCompanion(SleepDataCompanion data) {
    return SleepDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      endTimeStamp: data.endTimeStamp.present
          ? data.endTimeStamp.value
          : this.endTimeStamp,
      deepSleepSeconds: data.deepSleepSeconds.present
          ? data.deepSleepSeconds.value
          : this.deepSleepSeconds,
      lightSleepSeconds: data.lightSleepSeconds.present
          ? data.lightSleepSeconds.value
          : this.lightSleepSeconds,
      remSleepSeconds: data.remSleepSeconds.present
          ? data.remSleepSeconds.value
          : this.remSleepSeconds,
      isNewSleepProtocol: data.isNewSleepProtocol.present
          ? data.isNewSleepProtocol.value
          : this.isNewSleepProtocol,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('endTimeStamp: $endTimeStamp, ')
          ..write('deepSleepSeconds: $deepSleepSeconds, ')
          ..write('lightSleepSeconds: $lightSleepSeconds, ')
          ..write('remSleepSeconds: $remSleepSeconds, ')
          ..write('isNewSleepProtocol: $isNewSleepProtocol, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      startTimeStamp,
      endTimeStamp,
      deepSleepSeconds,
      lightSleepSeconds,
      remSleepSeconds,
      isNewSleepProtocol,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.endTimeStamp == this.endTimeStamp &&
          other.deepSleepSeconds == this.deepSleepSeconds &&
          other.lightSleepSeconds == this.lightSleepSeconds &&
          other.remSleepSeconds == this.remSleepSeconds &&
          other.isNewSleepProtocol == this.isNewSleepProtocol &&
          other.isSynced == this.isSynced);
}

class SleepDataCompanion extends UpdateCompanion<SleepDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> endTimeStamp;
  final Value<int> deepSleepSeconds;
  final Value<int> lightSleepSeconds;
  final Value<int> remSleepSeconds;
  final Value<bool> isNewSleepProtocol;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SleepDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.endTimeStamp = const Value.absent(),
    this.deepSleepSeconds = const Value.absent(),
    this.lightSleepSeconds = const Value.absent(),
    this.remSleepSeconds = const Value.absent(),
    this.isNewSleepProtocol = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int endTimeStamp,
    required int deepSleepSeconds,
    required int lightSleepSeconds,
    required int remSleepSeconds,
    this.isNewSleepProtocol = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        endTimeStamp = Value(endTimeStamp),
        deepSleepSeconds = Value(deepSleepSeconds),
        lightSleepSeconds = Value(lightSleepSeconds),
        remSleepSeconds = Value(remSleepSeconds);
  static Insertable<SleepDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? endTimeStamp,
    Expression<int>? deepSleepSeconds,
    Expression<int>? lightSleepSeconds,
    Expression<int>? remSleepSeconds,
    Expression<bool>? isNewSleepProtocol,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (endTimeStamp != null) 'end_time_stamp': endTimeStamp,
      if (deepSleepSeconds != null) 'deep_sleep_seconds': deepSleepSeconds,
      if (lightSleepSeconds != null) 'light_sleep_seconds': lightSleepSeconds,
      if (remSleepSeconds != null) 'rem_sleep_seconds': remSleepSeconds,
      if (isNewSleepProtocol != null)
        'is_new_sleep_protocol': isNewSleepProtocol,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? endTimeStamp,
      Value<int>? deepSleepSeconds,
      Value<int>? lightSleepSeconds,
      Value<int>? remSleepSeconds,
      Value<bool>? isNewSleepProtocol,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return SleepDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      endTimeStamp: endTimeStamp ?? this.endTimeStamp,
      deepSleepSeconds: deepSleepSeconds ?? this.deepSleepSeconds,
      lightSleepSeconds: lightSleepSeconds ?? this.lightSleepSeconds,
      remSleepSeconds: remSleepSeconds ?? this.remSleepSeconds,
      isNewSleepProtocol: isNewSleepProtocol ?? this.isNewSleepProtocol,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (endTimeStamp.present) {
      map['end_time_stamp'] = Variable<int>(endTimeStamp.value);
    }
    if (deepSleepSeconds.present) {
      map['deep_sleep_seconds'] = Variable<int>(deepSleepSeconds.value);
    }
    if (lightSleepSeconds.present) {
      map['light_sleep_seconds'] = Variable<int>(lightSleepSeconds.value);
    }
    if (remSleepSeconds.present) {
      map['rem_sleep_seconds'] = Variable<int>(remSleepSeconds.value);
    }
    if (isNewSleepProtocol.present) {
      map['is_new_sleep_protocol'] = Variable<bool>(isNewSleepProtocol.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('endTimeStamp: $endTimeStamp, ')
          ..write('deepSleepSeconds: $deepSleepSeconds, ')
          ..write('lightSleepSeconds: $lightSleepSeconds, ')
          ..write('remSleepSeconds: $remSleepSeconds, ')
          ..write('isNewSleepProtocol: $isNewSleepProtocol, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepDetailDataTable extends SleepDetailData
    with TableInfo<$SleepDetailDataTable, SleepDetailDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepDetailDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepStartTimeStampMeta =
      const VerificationMeta('sleepStartTimeStamp');
  @override
  late final GeneratedColumn<int> sleepStartTimeStamp = GeneratedColumn<int>(
      'sleep_start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sleepTypeMeta =
      const VerificationMeta('sleepType');
  @override
  late final GeneratedColumn<int> sleepType = GeneratedColumn<int>(
      'sleep_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        sleepStartTimeStamp,
        startTimeStamp,
        duration,
        sleepType,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_detail_data';
  @override
  VerificationContext validateIntegrity(
      Insertable<SleepDetailDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('sleep_start_time_stamp')) {
      context.handle(
          _sleepStartTimeStampMeta,
          sleepStartTimeStamp.isAcceptableOrUnknown(
              data['sleep_start_time_stamp']!, _sleepStartTimeStampMeta));
    } else if (isInserting) {
      context.missing(_sleepStartTimeStampMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('sleep_type')) {
      context.handle(_sleepTypeMeta,
          sleepType.isAcceptableOrUnknown(data['sleep_type']!, _sleepTypeMeta));
    } else if (isInserting) {
      context.missing(_sleepTypeMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {userId, sleepStartTimeStamp, startTimeStamp};
  @override
  SleepDetailDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepDetailDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      sleepStartTimeStamp: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sleep_start_time_stamp'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      sleepType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_type'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $SleepDetailDataTable createAlias(String alias) {
    return $SleepDetailDataTable(attachedDatabase, alias);
  }
}

class SleepDetailDataData extends DataClass
    implements Insertable<SleepDetailDataData> {
  final String userId;
  final int sleepStartTimeStamp;
  final int startTimeStamp;
  final int duration;
  final int sleepType;
  final bool isSynced;
  const SleepDetailDataData(
      {required this.userId,
      required this.sleepStartTimeStamp,
      required this.startTimeStamp,
      required this.duration,
      required this.sleepType,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['sleep_start_time_stamp'] = Variable<int>(sleepStartTimeStamp);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['duration'] = Variable<int>(duration);
    map['sleep_type'] = Variable<int>(sleepType);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SleepDetailDataCompanion toCompanion(bool nullToAbsent) {
    return SleepDetailDataCompanion(
      userId: Value(userId),
      sleepStartTimeStamp: Value(sleepStartTimeStamp),
      startTimeStamp: Value(startTimeStamp),
      duration: Value(duration),
      sleepType: Value(sleepType),
      isSynced: Value(isSynced),
    );
  }

  factory SleepDetailDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepDetailDataData(
      userId: serializer.fromJson<String>(json['userId']),
      sleepStartTimeStamp:
          serializer.fromJson<int>(json['sleepStartTimeStamp']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      duration: serializer.fromJson<int>(json['duration']),
      sleepType: serializer.fromJson<int>(json['sleepType']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'sleepStartTimeStamp': serializer.toJson<int>(sleepStartTimeStamp),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'duration': serializer.toJson<int>(duration),
      'sleepType': serializer.toJson<int>(sleepType),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SleepDetailDataData copyWith(
          {String? userId,
          int? sleepStartTimeStamp,
          int? startTimeStamp,
          int? duration,
          int? sleepType,
          bool? isSynced}) =>
      SleepDetailDataData(
        userId: userId ?? this.userId,
        sleepStartTimeStamp: sleepStartTimeStamp ?? this.sleepStartTimeStamp,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        duration: duration ?? this.duration,
        sleepType: sleepType ?? this.sleepType,
        isSynced: isSynced ?? this.isSynced,
      );
  SleepDetailDataData copyWithCompanion(SleepDetailDataCompanion data) {
    return SleepDetailDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      sleepStartTimeStamp: data.sleepStartTimeStamp.present
          ? data.sleepStartTimeStamp.value
          : this.sleepStartTimeStamp,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      duration: data.duration.present ? data.duration.value : this.duration,
      sleepType: data.sleepType.present ? data.sleepType.value : this.sleepType,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepDetailDataData(')
          ..write('userId: $userId, ')
          ..write('sleepStartTimeStamp: $sleepStartTimeStamp, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('duration: $duration, ')
          ..write('sleepType: $sleepType, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, sleepStartTimeStamp, startTimeStamp,
      duration, sleepType, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepDetailDataData &&
          other.userId == this.userId &&
          other.sleepStartTimeStamp == this.sleepStartTimeStamp &&
          other.startTimeStamp == this.startTimeStamp &&
          other.duration == this.duration &&
          other.sleepType == this.sleepType &&
          other.isSynced == this.isSynced);
}

class SleepDetailDataCompanion extends UpdateCompanion<SleepDetailDataData> {
  final Value<String> userId;
  final Value<int> sleepStartTimeStamp;
  final Value<int> startTimeStamp;
  final Value<int> duration;
  final Value<int> sleepType;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SleepDetailDataCompanion({
    this.userId = const Value.absent(),
    this.sleepStartTimeStamp = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.duration = const Value.absent(),
    this.sleepType = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepDetailDataCompanion.insert({
    required String userId,
    required int sleepStartTimeStamp,
    required int startTimeStamp,
    required int duration,
    required int sleepType,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        sleepStartTimeStamp = Value(sleepStartTimeStamp),
        startTimeStamp = Value(startTimeStamp),
        duration = Value(duration),
        sleepType = Value(sleepType);
  static Insertable<SleepDetailDataData> custom({
    Expression<String>? userId,
    Expression<int>? sleepStartTimeStamp,
    Expression<int>? startTimeStamp,
    Expression<int>? duration,
    Expression<int>? sleepType,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (sleepStartTimeStamp != null)
        'sleep_start_time_stamp': sleepStartTimeStamp,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (duration != null) 'duration': duration,
      if (sleepType != null) 'sleep_type': sleepType,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepDetailDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? sleepStartTimeStamp,
      Value<int>? startTimeStamp,
      Value<int>? duration,
      Value<int>? sleepType,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return SleepDetailDataCompanion(
      userId: userId ?? this.userId,
      sleepStartTimeStamp: sleepStartTimeStamp ?? this.sleepStartTimeStamp,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      duration: duration ?? this.duration,
      sleepType: sleepType ?? this.sleepType,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (sleepStartTimeStamp.present) {
      map['sleep_start_time_stamp'] = Variable<int>(sleepStartTimeStamp.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (sleepType.present) {
      map['sleep_type'] = Variable<int>(sleepType.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepDetailDataCompanion(')
          ..write('userId: $userId, ')
          ..write('sleepStartTimeStamp: $sleepStartTimeStamp, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('duration: $duration, ')
          ..write('sleepType: $sleepType, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HeartRateDataTable extends HeartRateData
    with TableInfo<$HeartRateDataTable, HeartRateDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeartRateDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heartRateMeta =
      const VerificationMeta('heartRate');
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
      'heart_rate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [userId, startTimeStamp, heartRate, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'heart_rate_data';
  @override
  VerificationContext validateIntegrity(Insertable<HeartRateDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(_heartRateMeta,
          heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta));
    } else if (isInserting) {
      context.missing(_heartRateMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  HeartRateDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HeartRateDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      heartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $HeartRateDataTable createAlias(String alias) {
    return $HeartRateDataTable(attachedDatabase, alias);
  }
}

class HeartRateDataData extends DataClass
    implements Insertable<HeartRateDataData> {
  final String userId;
  final int startTimeStamp;
  final int heartRate;
  final bool isSynced;
  const HeartRateDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.heartRate,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['heart_rate'] = Variable<int>(heartRate);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  HeartRateDataCompanion toCompanion(bool nullToAbsent) {
    return HeartRateDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      heartRate: Value(heartRate),
      isSynced: Value(isSynced),
    );
  }

  factory HeartRateDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HeartRateDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'heartRate': serializer.toJson<int>(heartRate),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  HeartRateDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? heartRate,
          bool? isSynced}) =>
      HeartRateDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        heartRate: heartRate ?? this.heartRate,
        isSynced: isSynced ?? this.isSynced,
      );
  HeartRateDataData copyWithCompanion(HeartRateDataCompanion data) {
    return HeartRateDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HeartRateDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, startTimeStamp, heartRate, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HeartRateDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.heartRate == this.heartRate &&
          other.isSynced == this.isSynced);
}

class HeartRateDataCompanion extends UpdateCompanion<HeartRateDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> heartRate;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const HeartRateDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HeartRateDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int heartRate,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        heartRate = Value(heartRate);
  static Insertable<HeartRateDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? heartRate,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (heartRate != null) 'heart_rate': heartRate,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HeartRateDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? heartRate,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return HeartRateDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      heartRate: heartRate ?? this.heartRate,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeartRateDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BloodPressureDataTable extends BloodPressureData
    with TableInfo<$BloodPressureDataTable, BloodPressureDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodPressureDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _systolicBloodPressureMeta =
      const VerificationMeta('systolicBloodPressure');
  @override
  late final GeneratedColumn<int> systolicBloodPressure = GeneratedColumn<int>(
      'systolic_blood_pressure', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diastolicBloodPressureMeta =
      const VerificationMeta('diastolicBloodPressure');
  @override
  late final GeneratedColumn<int> diastolicBloodPressure = GeneratedColumn<int>(
      'diastolic_blood_pressure', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<int> mode = GeneratedColumn<int>(
      'mode', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        startTimeStamp,
        systolicBloodPressure,
        diastolicBloodPressure,
        mode,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_pressure_data';
  @override
  VerificationContext validateIntegrity(
      Insertable<BloodPressureDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('systolic_blood_pressure')) {
      context.handle(
          _systolicBloodPressureMeta,
          systolicBloodPressure.isAcceptableOrUnknown(
              data['systolic_blood_pressure']!, _systolicBloodPressureMeta));
    } else if (isInserting) {
      context.missing(_systolicBloodPressureMeta);
    }
    if (data.containsKey('diastolic_blood_pressure')) {
      context.handle(
          _diastolicBloodPressureMeta,
          diastolicBloodPressure.isAcceptableOrUnknown(
              data['diastolic_blood_pressure']!, _diastolicBloodPressureMeta));
    } else if (isInserting) {
      context.missing(_diastolicBloodPressureMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  BloodPressureDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodPressureDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      systolicBloodPressure: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}systolic_blood_pressure'])!,
      diastolicBloodPressure: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}diastolic_blood_pressure'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mode'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $BloodPressureDataTable createAlias(String alias) {
    return $BloodPressureDataTable(attachedDatabase, alias);
  }
}

class BloodPressureDataData extends DataClass
    implements Insertable<BloodPressureDataData> {
  final String userId;
  final int startTimeStamp;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int mode;
  final bool isSynced;
  const BloodPressureDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.systolicBloodPressure,
      required this.diastolicBloodPressure,
      required this.mode,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['systolic_blood_pressure'] = Variable<int>(systolicBloodPressure);
    map['diastolic_blood_pressure'] = Variable<int>(diastolicBloodPressure);
    map['mode'] = Variable<int>(mode);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  BloodPressureDataCompanion toCompanion(bool nullToAbsent) {
    return BloodPressureDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      systolicBloodPressure: Value(systolicBloodPressure),
      diastolicBloodPressure: Value(diastolicBloodPressure),
      mode: Value(mode),
      isSynced: Value(isSynced),
    );
  }

  factory BloodPressureDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodPressureDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      systolicBloodPressure:
          serializer.fromJson<int>(json['systolicBloodPressure']),
      diastolicBloodPressure:
          serializer.fromJson<int>(json['diastolicBloodPressure']),
      mode: serializer.fromJson<int>(json['mode']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'systolicBloodPressure': serializer.toJson<int>(systolicBloodPressure),
      'diastolicBloodPressure': serializer.toJson<int>(diastolicBloodPressure),
      'mode': serializer.toJson<int>(mode),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  BloodPressureDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? systolicBloodPressure,
          int? diastolicBloodPressure,
          int? mode,
          bool? isSynced}) =>
      BloodPressureDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        systolicBloodPressure:
            systolicBloodPressure ?? this.systolicBloodPressure,
        diastolicBloodPressure:
            diastolicBloodPressure ?? this.diastolicBloodPressure,
        mode: mode ?? this.mode,
        isSynced: isSynced ?? this.isSynced,
      );
  BloodPressureDataData copyWithCompanion(BloodPressureDataCompanion data) {
    return BloodPressureDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      systolicBloodPressure: data.systolicBloodPressure.present
          ? data.systolicBloodPressure.value
          : this.systolicBloodPressure,
      diastolicBloodPressure: data.diastolicBloodPressure.present
          ? data.diastolicBloodPressure.value
          : this.diastolicBloodPressure,
      mode: data.mode.present ? data.mode.value : this.mode,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('systolicBloodPressure: $systolicBloodPressure, ')
          ..write('diastolicBloodPressure: $diastolicBloodPressure, ')
          ..write('mode: $mode, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, startTimeStamp, systolicBloodPressure,
      diastolicBloodPressure, mode, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodPressureDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.systolicBloodPressure == this.systolicBloodPressure &&
          other.diastolicBloodPressure == this.diastolicBloodPressure &&
          other.mode == this.mode &&
          other.isSynced == this.isSynced);
}

class BloodPressureDataCompanion
    extends UpdateCompanion<BloodPressureDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> systolicBloodPressure;
  final Value<int> diastolicBloodPressure;
  final Value<int> mode;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const BloodPressureDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.systolicBloodPressure = const Value.absent(),
    this.diastolicBloodPressure = const Value.absent(),
    this.mode = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BloodPressureDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int systolicBloodPressure,
    required int diastolicBloodPressure,
    required int mode,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        systolicBloodPressure = Value(systolicBloodPressure),
        diastolicBloodPressure = Value(diastolicBloodPressure),
        mode = Value(mode);
  static Insertable<BloodPressureDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? systolicBloodPressure,
    Expression<int>? diastolicBloodPressure,
    Expression<int>? mode,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (systolicBloodPressure != null)
        'systolic_blood_pressure': systolicBloodPressure,
      if (diastolicBloodPressure != null)
        'diastolic_blood_pressure': diastolicBloodPressure,
      if (mode != null) 'mode': mode,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BloodPressureDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? systolicBloodPressure,
      Value<int>? diastolicBloodPressure,
      Value<int>? mode,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return BloodPressureDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      systolicBloodPressure:
          systolicBloodPressure ?? this.systolicBloodPressure,
      diastolicBloodPressure:
          diastolicBloodPressure ?? this.diastolicBloodPressure,
      mode: mode ?? this.mode,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (systolicBloodPressure.present) {
      map['systolic_blood_pressure'] =
          Variable<int>(systolicBloodPressure.value);
    }
    if (diastolicBloodPressure.present) {
      map['diastolic_blood_pressure'] =
          Variable<int>(diastolicBloodPressure.value);
    }
    if (mode.present) {
      map['mode'] = Variable<int>(mode.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('systolicBloodPressure: $systolicBloodPressure, ')
          ..write('diastolicBloodPressure: $diastolicBloodPressure, ')
          ..write('mode: $mode, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CombinedDataTable extends CombinedData
    with TableInfo<$CombinedDataTable, CombinedDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CombinedDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
      'step', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heartRateMeta =
      const VerificationMeta('heartRate');
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
      'heart_rate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _systolicBloodPressureMeta =
      const VerificationMeta('systolicBloodPressure');
  @override
  late final GeneratedColumn<int> systolicBloodPressure = GeneratedColumn<int>(
      'systolic_blood_pressure', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diastolicBloodPressureMeta =
      const VerificationMeta('diastolicBloodPressure');
  @override
  late final GeneratedColumn<int> diastolicBloodPressure = GeneratedColumn<int>(
      'diastolic_blood_pressure', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodOxygenMeta =
      const VerificationMeta('bloodOxygen');
  @override
  late final GeneratedColumn<int> bloodOxygen = GeneratedColumn<int>(
      'blood_oxygen', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _respirationRateMeta =
      const VerificationMeta('respirationRate');
  @override
  late final GeneratedColumn<int> respirationRate = GeneratedColumn<int>(
      'respiration_rate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hrvMeta = const VerificationMeta('hrv');
  @override
  late final GeneratedColumn<int> hrv = GeneratedColumn<int>(
      'hrv', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cvrrMeta = const VerificationMeta('cvrr');
  @override
  late final GeneratedColumn<int> cvrr = GeneratedColumn<int>(
      'cvrr', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodGlucoseMeta =
      const VerificationMeta('bloodGlucose');
  @override
  late final GeneratedColumn<double> bloodGlucose = GeneratedColumn<double>(
      'blood_glucose', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
      'fat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        startTimeStamp,
        step,
        heartRate,
        systolicBloodPressure,
        diastolicBloodPressure,
        bloodOxygen,
        respirationRate,
        hrv,
        cvrr,
        bloodGlucose,
        fat,
        temperature,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'combined_data';
  @override
  VerificationContext validateIntegrity(Insertable<CombinedDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('step')) {
      context.handle(
          _stepMeta, step.isAcceptableOrUnknown(data['step']!, _stepMeta));
    } else if (isInserting) {
      context.missing(_stepMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(_heartRateMeta,
          heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta));
    } else if (isInserting) {
      context.missing(_heartRateMeta);
    }
    if (data.containsKey('systolic_blood_pressure')) {
      context.handle(
          _systolicBloodPressureMeta,
          systolicBloodPressure.isAcceptableOrUnknown(
              data['systolic_blood_pressure']!, _systolicBloodPressureMeta));
    } else if (isInserting) {
      context.missing(_systolicBloodPressureMeta);
    }
    if (data.containsKey('diastolic_blood_pressure')) {
      context.handle(
          _diastolicBloodPressureMeta,
          diastolicBloodPressure.isAcceptableOrUnknown(
              data['diastolic_blood_pressure']!, _diastolicBloodPressureMeta));
    } else if (isInserting) {
      context.missing(_diastolicBloodPressureMeta);
    }
    if (data.containsKey('blood_oxygen')) {
      context.handle(
          _bloodOxygenMeta,
          bloodOxygen.isAcceptableOrUnknown(
              data['blood_oxygen']!, _bloodOxygenMeta));
    } else if (isInserting) {
      context.missing(_bloodOxygenMeta);
    }
    if (data.containsKey('respiration_rate')) {
      context.handle(
          _respirationRateMeta,
          respirationRate.isAcceptableOrUnknown(
              data['respiration_rate']!, _respirationRateMeta));
    } else if (isInserting) {
      context.missing(_respirationRateMeta);
    }
    if (data.containsKey('hrv')) {
      context.handle(
          _hrvMeta, hrv.isAcceptableOrUnknown(data['hrv']!, _hrvMeta));
    } else if (isInserting) {
      context.missing(_hrvMeta);
    }
    if (data.containsKey('cvrr')) {
      context.handle(
          _cvrrMeta, cvrr.isAcceptableOrUnknown(data['cvrr']!, _cvrrMeta));
    } else if (isInserting) {
      context.missing(_cvrrMeta);
    }
    if (data.containsKey('blood_glucose')) {
      context.handle(
          _bloodGlucoseMeta,
          bloodGlucose.isAcceptableOrUnknown(
              data['blood_glucose']!, _bloodGlucoseMeta));
    } else if (isInserting) {
      context.missing(_bloodGlucoseMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  CombinedDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CombinedDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      step: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step'])!,
      heartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate'])!,
      systolicBloodPressure: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}systolic_blood_pressure'])!,
      diastolicBloodPressure: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}diastolic_blood_pressure'])!,
      bloodOxygen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}blood_oxygen'])!,
      respirationRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}respiration_rate'])!,
      hrv: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hrv'])!,
      cvrr: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cvrr'])!,
      bloodGlucose: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}blood_glucose'])!,
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $CombinedDataTable createAlias(String alias) {
    return $CombinedDataTable(attachedDatabase, alias);
  }
}

class CombinedDataData extends DataClass
    implements Insertable<CombinedDataData> {
  final String userId;
  final int startTimeStamp;
  final int step;
  final int heartRate;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int bloodOxygen;
  final int respirationRate;
  final int hrv;
  final int cvrr;
  final double bloodGlucose;
  final double fat;
  final double temperature;
  final bool isSynced;
  const CombinedDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.step,
      required this.heartRate,
      required this.systolicBloodPressure,
      required this.diastolicBloodPressure,
      required this.bloodOxygen,
      required this.respirationRate,
      required this.hrv,
      required this.cvrr,
      required this.bloodGlucose,
      required this.fat,
      required this.temperature,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['step'] = Variable<int>(step);
    map['heart_rate'] = Variable<int>(heartRate);
    map['systolic_blood_pressure'] = Variable<int>(systolicBloodPressure);
    map['diastolic_blood_pressure'] = Variable<int>(diastolicBloodPressure);
    map['blood_oxygen'] = Variable<int>(bloodOxygen);
    map['respiration_rate'] = Variable<int>(respirationRate);
    map['hrv'] = Variable<int>(hrv);
    map['cvrr'] = Variable<int>(cvrr);
    map['blood_glucose'] = Variable<double>(bloodGlucose);
    map['fat'] = Variable<double>(fat);
    map['temperature'] = Variable<double>(temperature);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  CombinedDataCompanion toCompanion(bool nullToAbsent) {
    return CombinedDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      step: Value(step),
      heartRate: Value(heartRate),
      systolicBloodPressure: Value(systolicBloodPressure),
      diastolicBloodPressure: Value(diastolicBloodPressure),
      bloodOxygen: Value(bloodOxygen),
      respirationRate: Value(respirationRate),
      hrv: Value(hrv),
      cvrr: Value(cvrr),
      bloodGlucose: Value(bloodGlucose),
      fat: Value(fat),
      temperature: Value(temperature),
      isSynced: Value(isSynced),
    );
  }

  factory CombinedDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CombinedDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      step: serializer.fromJson<int>(json['step']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      systolicBloodPressure:
          serializer.fromJson<int>(json['systolicBloodPressure']),
      diastolicBloodPressure:
          serializer.fromJson<int>(json['diastolicBloodPressure']),
      bloodOxygen: serializer.fromJson<int>(json['bloodOxygen']),
      respirationRate: serializer.fromJson<int>(json['respirationRate']),
      hrv: serializer.fromJson<int>(json['hrv']),
      cvrr: serializer.fromJson<int>(json['cvrr']),
      bloodGlucose: serializer.fromJson<double>(json['bloodGlucose']),
      fat: serializer.fromJson<double>(json['fat']),
      temperature: serializer.fromJson<double>(json['temperature']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'step': serializer.toJson<int>(step),
      'heartRate': serializer.toJson<int>(heartRate),
      'systolicBloodPressure': serializer.toJson<int>(systolicBloodPressure),
      'diastolicBloodPressure': serializer.toJson<int>(diastolicBloodPressure),
      'bloodOxygen': serializer.toJson<int>(bloodOxygen),
      'respirationRate': serializer.toJson<int>(respirationRate),
      'hrv': serializer.toJson<int>(hrv),
      'cvrr': serializer.toJson<int>(cvrr),
      'bloodGlucose': serializer.toJson<double>(bloodGlucose),
      'fat': serializer.toJson<double>(fat),
      'temperature': serializer.toJson<double>(temperature),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  CombinedDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? step,
          int? heartRate,
          int? systolicBloodPressure,
          int? diastolicBloodPressure,
          int? bloodOxygen,
          int? respirationRate,
          int? hrv,
          int? cvrr,
          double? bloodGlucose,
          double? fat,
          double? temperature,
          bool? isSynced}) =>
      CombinedDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        step: step ?? this.step,
        heartRate: heartRate ?? this.heartRate,
        systolicBloodPressure:
            systolicBloodPressure ?? this.systolicBloodPressure,
        diastolicBloodPressure:
            diastolicBloodPressure ?? this.diastolicBloodPressure,
        bloodOxygen: bloodOxygen ?? this.bloodOxygen,
        respirationRate: respirationRate ?? this.respirationRate,
        hrv: hrv ?? this.hrv,
        cvrr: cvrr ?? this.cvrr,
        bloodGlucose: bloodGlucose ?? this.bloodGlucose,
        fat: fat ?? this.fat,
        temperature: temperature ?? this.temperature,
        isSynced: isSynced ?? this.isSynced,
      );
  CombinedDataData copyWithCompanion(CombinedDataCompanion data) {
    return CombinedDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      step: data.step.present ? data.step.value : this.step,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      systolicBloodPressure: data.systolicBloodPressure.present
          ? data.systolicBloodPressure.value
          : this.systolicBloodPressure,
      diastolicBloodPressure: data.diastolicBloodPressure.present
          ? data.diastolicBloodPressure.value
          : this.diastolicBloodPressure,
      bloodOxygen:
          data.bloodOxygen.present ? data.bloodOxygen.value : this.bloodOxygen,
      respirationRate: data.respirationRate.present
          ? data.respirationRate.value
          : this.respirationRate,
      hrv: data.hrv.present ? data.hrv.value : this.hrv,
      cvrr: data.cvrr.present ? data.cvrr.value : this.cvrr,
      bloodGlucose: data.bloodGlucose.present
          ? data.bloodGlucose.value
          : this.bloodGlucose,
      fat: data.fat.present ? data.fat.value : this.fat,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CombinedDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('step: $step, ')
          ..write('heartRate: $heartRate, ')
          ..write('systolicBloodPressure: $systolicBloodPressure, ')
          ..write('diastolicBloodPressure: $diastolicBloodPressure, ')
          ..write('bloodOxygen: $bloodOxygen, ')
          ..write('respirationRate: $respirationRate, ')
          ..write('hrv: $hrv, ')
          ..write('cvrr: $cvrr, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('fat: $fat, ')
          ..write('temperature: $temperature, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      startTimeStamp,
      step,
      heartRate,
      systolicBloodPressure,
      diastolicBloodPressure,
      bloodOxygen,
      respirationRate,
      hrv,
      cvrr,
      bloodGlucose,
      fat,
      temperature,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CombinedDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.step == this.step &&
          other.heartRate == this.heartRate &&
          other.systolicBloodPressure == this.systolicBloodPressure &&
          other.diastolicBloodPressure == this.diastolicBloodPressure &&
          other.bloodOxygen == this.bloodOxygen &&
          other.respirationRate == this.respirationRate &&
          other.hrv == this.hrv &&
          other.cvrr == this.cvrr &&
          other.bloodGlucose == this.bloodGlucose &&
          other.fat == this.fat &&
          other.temperature == this.temperature &&
          other.isSynced == this.isSynced);
}

class CombinedDataCompanion extends UpdateCompanion<CombinedDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> step;
  final Value<int> heartRate;
  final Value<int> systolicBloodPressure;
  final Value<int> diastolicBloodPressure;
  final Value<int> bloodOxygen;
  final Value<int> respirationRate;
  final Value<int> hrv;
  final Value<int> cvrr;
  final Value<double> bloodGlucose;
  final Value<double> fat;
  final Value<double> temperature;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const CombinedDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.step = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.systolicBloodPressure = const Value.absent(),
    this.diastolicBloodPressure = const Value.absent(),
    this.bloodOxygen = const Value.absent(),
    this.respirationRate = const Value.absent(),
    this.hrv = const Value.absent(),
    this.cvrr = const Value.absent(),
    this.bloodGlucose = const Value.absent(),
    this.fat = const Value.absent(),
    this.temperature = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CombinedDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int step,
    required int heartRate,
    required int systolicBloodPressure,
    required int diastolicBloodPressure,
    required int bloodOxygen,
    required int respirationRate,
    required int hrv,
    required int cvrr,
    required double bloodGlucose,
    required double fat,
    required double temperature,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        step = Value(step),
        heartRate = Value(heartRate),
        systolicBloodPressure = Value(systolicBloodPressure),
        diastolicBloodPressure = Value(diastolicBloodPressure),
        bloodOxygen = Value(bloodOxygen),
        respirationRate = Value(respirationRate),
        hrv = Value(hrv),
        cvrr = Value(cvrr),
        bloodGlucose = Value(bloodGlucose),
        fat = Value(fat),
        temperature = Value(temperature);
  static Insertable<CombinedDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? step,
    Expression<int>? heartRate,
    Expression<int>? systolicBloodPressure,
    Expression<int>? diastolicBloodPressure,
    Expression<int>? bloodOxygen,
    Expression<int>? respirationRate,
    Expression<int>? hrv,
    Expression<int>? cvrr,
    Expression<double>? bloodGlucose,
    Expression<double>? fat,
    Expression<double>? temperature,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (step != null) 'step': step,
      if (heartRate != null) 'heart_rate': heartRate,
      if (systolicBloodPressure != null)
        'systolic_blood_pressure': systolicBloodPressure,
      if (diastolicBloodPressure != null)
        'diastolic_blood_pressure': diastolicBloodPressure,
      if (bloodOxygen != null) 'blood_oxygen': bloodOxygen,
      if (respirationRate != null) 'respiration_rate': respirationRate,
      if (hrv != null) 'hrv': hrv,
      if (cvrr != null) 'cvrr': cvrr,
      if (bloodGlucose != null) 'blood_glucose': bloodGlucose,
      if (fat != null) 'fat': fat,
      if (temperature != null) 'temperature': temperature,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CombinedDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? step,
      Value<int>? heartRate,
      Value<int>? systolicBloodPressure,
      Value<int>? diastolicBloodPressure,
      Value<int>? bloodOxygen,
      Value<int>? respirationRate,
      Value<int>? hrv,
      Value<int>? cvrr,
      Value<double>? bloodGlucose,
      Value<double>? fat,
      Value<double>? temperature,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return CombinedDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      step: step ?? this.step,
      heartRate: heartRate ?? this.heartRate,
      systolicBloodPressure:
          systolicBloodPressure ?? this.systolicBloodPressure,
      diastolicBloodPressure:
          diastolicBloodPressure ?? this.diastolicBloodPressure,
      bloodOxygen: bloodOxygen ?? this.bloodOxygen,
      respirationRate: respirationRate ?? this.respirationRate,
      hrv: hrv ?? this.hrv,
      cvrr: cvrr ?? this.cvrr,
      bloodGlucose: bloodGlucose ?? this.bloodGlucose,
      fat: fat ?? this.fat,
      temperature: temperature ?? this.temperature,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (systolicBloodPressure.present) {
      map['systolic_blood_pressure'] =
          Variable<int>(systolicBloodPressure.value);
    }
    if (diastolicBloodPressure.present) {
      map['diastolic_blood_pressure'] =
          Variable<int>(diastolicBloodPressure.value);
    }
    if (bloodOxygen.present) {
      map['blood_oxygen'] = Variable<int>(bloodOxygen.value);
    }
    if (respirationRate.present) {
      map['respiration_rate'] = Variable<int>(respirationRate.value);
    }
    if (hrv.present) {
      map['hrv'] = Variable<int>(hrv.value);
    }
    if (cvrr.present) {
      map['cvrr'] = Variable<int>(cvrr.value);
    }
    if (bloodGlucose.present) {
      map['blood_glucose'] = Variable<double>(bloodGlucose.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CombinedDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('step: $step, ')
          ..write('heartRate: $heartRate, ')
          ..write('systolicBloodPressure: $systolicBloodPressure, ')
          ..write('diastolicBloodPressure: $diastolicBloodPressure, ')
          ..write('bloodOxygen: $bloodOxygen, ')
          ..write('respirationRate: $respirationRate, ')
          ..write('hrv: $hrv, ')
          ..write('cvrr: $cvrr, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('fat: $fat, ')
          ..write('temperature: $temperature, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvasiveComprehensiveDataTable extends InvasiveComprehensiveData
    with
        TableInfo<$InvasiveComprehensiveDataTable,
            InvasiveComprehensiveDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvasiveComprehensiveDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodGlucoseModeMeta =
      const VerificationMeta('bloodGlucoseMode');
  @override
  late final GeneratedColumn<int> bloodGlucoseMode = GeneratedColumn<int>(
      'blood_glucose_mode', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodGlucoseMeta =
      const VerificationMeta('bloodGlucose');
  @override
  late final GeneratedColumn<double> bloodGlucose = GeneratedColumn<double>(
      'blood_glucose', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _uricAcidModeMeta =
      const VerificationMeta('uricAcidMode');
  @override
  late final GeneratedColumn<int> uricAcidMode = GeneratedColumn<int>(
      'uric_acid_mode', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _uricAcidMeta =
      const VerificationMeta('uricAcid');
  @override
  late final GeneratedColumn<int> uricAcid = GeneratedColumn<int>(
      'uric_acid', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodKetoneModeMeta =
      const VerificationMeta('bloodKetoneMode');
  @override
  late final GeneratedColumn<int> bloodKetoneMode = GeneratedColumn<int>(
      'blood_ketone_mode', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bloodKetoneMeta =
      const VerificationMeta('bloodKetone');
  @override
  late final GeneratedColumn<double> bloodKetone = GeneratedColumn<double>(
      'blood_ketone', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _bloodFatModeMeta =
      const VerificationMeta('bloodFatMode');
  @override
  late final GeneratedColumn<int> bloodFatMode = GeneratedColumn<int>(
      'blood_fat_mode', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalCholesterolMeta =
      const VerificationMeta('totalCholesterol');
  @override
  late final GeneratedColumn<double> totalCholesterol = GeneratedColumn<double>(
      'total_cholesterol', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _hdlCholesterolMeta =
      const VerificationMeta('hdlCholesterol');
  @override
  late final GeneratedColumn<double> hdlCholesterol = GeneratedColumn<double>(
      'hdl_cholesterol', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ldlCholesterolMeta =
      const VerificationMeta('ldlCholesterol');
  @override
  late final GeneratedColumn<double> ldlCholesterol = GeneratedColumn<double>(
      'ldl_cholesterol', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _triglyceridesMeta =
      const VerificationMeta('triglycerides');
  @override
  late final GeneratedColumn<double> triglycerides = GeneratedColumn<double>(
      'triglycerides', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        startTimeStamp,
        bloodGlucoseMode,
        bloodGlucose,
        uricAcidMode,
        uricAcid,
        bloodKetoneMode,
        bloodKetone,
        bloodFatMode,
        totalCholesterol,
        hdlCholesterol,
        ldlCholesterol,
        triglycerides,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invasive_comprehensive_data';
  @override
  VerificationContext validateIntegrity(
      Insertable<InvasiveComprehensiveDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('blood_glucose_mode')) {
      context.handle(
          _bloodGlucoseModeMeta,
          bloodGlucoseMode.isAcceptableOrUnknown(
              data['blood_glucose_mode']!, _bloodGlucoseModeMeta));
    } else if (isInserting) {
      context.missing(_bloodGlucoseModeMeta);
    }
    if (data.containsKey('blood_glucose')) {
      context.handle(
          _bloodGlucoseMeta,
          bloodGlucose.isAcceptableOrUnknown(
              data['blood_glucose']!, _bloodGlucoseMeta));
    } else if (isInserting) {
      context.missing(_bloodGlucoseMeta);
    }
    if (data.containsKey('uric_acid_mode')) {
      context.handle(
          _uricAcidModeMeta,
          uricAcidMode.isAcceptableOrUnknown(
              data['uric_acid_mode']!, _uricAcidModeMeta));
    } else if (isInserting) {
      context.missing(_uricAcidModeMeta);
    }
    if (data.containsKey('uric_acid')) {
      context.handle(_uricAcidMeta,
          uricAcid.isAcceptableOrUnknown(data['uric_acid']!, _uricAcidMeta));
    } else if (isInserting) {
      context.missing(_uricAcidMeta);
    }
    if (data.containsKey('blood_ketone_mode')) {
      context.handle(
          _bloodKetoneModeMeta,
          bloodKetoneMode.isAcceptableOrUnknown(
              data['blood_ketone_mode']!, _bloodKetoneModeMeta));
    } else if (isInserting) {
      context.missing(_bloodKetoneModeMeta);
    }
    if (data.containsKey('blood_ketone')) {
      context.handle(
          _bloodKetoneMeta,
          bloodKetone.isAcceptableOrUnknown(
              data['blood_ketone']!, _bloodKetoneMeta));
    } else if (isInserting) {
      context.missing(_bloodKetoneMeta);
    }
    if (data.containsKey('blood_fat_mode')) {
      context.handle(
          _bloodFatModeMeta,
          bloodFatMode.isAcceptableOrUnknown(
              data['blood_fat_mode']!, _bloodFatModeMeta));
    } else if (isInserting) {
      context.missing(_bloodFatModeMeta);
    }
    if (data.containsKey('total_cholesterol')) {
      context.handle(
          _totalCholesterolMeta,
          totalCholesterol.isAcceptableOrUnknown(
              data['total_cholesterol']!, _totalCholesterolMeta));
    } else if (isInserting) {
      context.missing(_totalCholesterolMeta);
    }
    if (data.containsKey('hdl_cholesterol')) {
      context.handle(
          _hdlCholesterolMeta,
          hdlCholesterol.isAcceptableOrUnknown(
              data['hdl_cholesterol']!, _hdlCholesterolMeta));
    } else if (isInserting) {
      context.missing(_hdlCholesterolMeta);
    }
    if (data.containsKey('ldl_cholesterol')) {
      context.handle(
          _ldlCholesterolMeta,
          ldlCholesterol.isAcceptableOrUnknown(
              data['ldl_cholesterol']!, _ldlCholesterolMeta));
    } else if (isInserting) {
      context.missing(_ldlCholesterolMeta);
    }
    if (data.containsKey('triglycerides')) {
      context.handle(
          _triglyceridesMeta,
          triglycerides.isAcceptableOrUnknown(
              data['triglycerides']!, _triglyceridesMeta));
    } else if (isInserting) {
      context.missing(_triglyceridesMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  InvasiveComprehensiveDataData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvasiveComprehensiveDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      bloodGlucoseMode: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}blood_glucose_mode'])!,
      bloodGlucose: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}blood_glucose'])!,
      uricAcidMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uric_acid_mode'])!,
      uricAcid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uric_acid'])!,
      bloodKetoneMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}blood_ketone_mode'])!,
      bloodKetone: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}blood_ketone'])!,
      bloodFatMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}blood_fat_mode'])!,
      totalCholesterol: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_cholesterol'])!,
      hdlCholesterol: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}hdl_cholesterol'])!,
      ldlCholesterol: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}ldl_cholesterol'])!,
      triglycerides: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}triglycerides'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $InvasiveComprehensiveDataTable createAlias(String alias) {
    return $InvasiveComprehensiveDataTable(attachedDatabase, alias);
  }
}

class InvasiveComprehensiveDataData extends DataClass
    implements Insertable<InvasiveComprehensiveDataData> {
  final String userId;
  final int startTimeStamp;
  final int bloodGlucoseMode;
  final double bloodGlucose;
  final int uricAcidMode;
  final int uricAcid;
  final int bloodKetoneMode;
  final double bloodKetone;
  final int bloodFatMode;
  final double totalCholesterol;
  final double hdlCholesterol;
  final double ldlCholesterol;
  final double triglycerides;
  final bool isSynced;
  const InvasiveComprehensiveDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.bloodGlucoseMode,
      required this.bloodGlucose,
      required this.uricAcidMode,
      required this.uricAcid,
      required this.bloodKetoneMode,
      required this.bloodKetone,
      required this.bloodFatMode,
      required this.totalCholesterol,
      required this.hdlCholesterol,
      required this.ldlCholesterol,
      required this.triglycerides,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['blood_glucose_mode'] = Variable<int>(bloodGlucoseMode);
    map['blood_glucose'] = Variable<double>(bloodGlucose);
    map['uric_acid_mode'] = Variable<int>(uricAcidMode);
    map['uric_acid'] = Variable<int>(uricAcid);
    map['blood_ketone_mode'] = Variable<int>(bloodKetoneMode);
    map['blood_ketone'] = Variable<double>(bloodKetone);
    map['blood_fat_mode'] = Variable<int>(bloodFatMode);
    map['total_cholesterol'] = Variable<double>(totalCholesterol);
    map['hdl_cholesterol'] = Variable<double>(hdlCholesterol);
    map['ldl_cholesterol'] = Variable<double>(ldlCholesterol);
    map['triglycerides'] = Variable<double>(triglycerides);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  InvasiveComprehensiveDataCompanion toCompanion(bool nullToAbsent) {
    return InvasiveComprehensiveDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      bloodGlucoseMode: Value(bloodGlucoseMode),
      bloodGlucose: Value(bloodGlucose),
      uricAcidMode: Value(uricAcidMode),
      uricAcid: Value(uricAcid),
      bloodKetoneMode: Value(bloodKetoneMode),
      bloodKetone: Value(bloodKetone),
      bloodFatMode: Value(bloodFatMode),
      totalCholesterol: Value(totalCholesterol),
      hdlCholesterol: Value(hdlCholesterol),
      ldlCholesterol: Value(ldlCholesterol),
      triglycerides: Value(triglycerides),
      isSynced: Value(isSynced),
    );
  }

  factory InvasiveComprehensiveDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvasiveComprehensiveDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      bloodGlucoseMode: serializer.fromJson<int>(json['bloodGlucoseMode']),
      bloodGlucose: serializer.fromJson<double>(json['bloodGlucose']),
      uricAcidMode: serializer.fromJson<int>(json['uricAcidMode']),
      uricAcid: serializer.fromJson<int>(json['uricAcid']),
      bloodKetoneMode: serializer.fromJson<int>(json['bloodKetoneMode']),
      bloodKetone: serializer.fromJson<double>(json['bloodKetone']),
      bloodFatMode: serializer.fromJson<int>(json['bloodFatMode']),
      totalCholesterol: serializer.fromJson<double>(json['totalCholesterol']),
      hdlCholesterol: serializer.fromJson<double>(json['hdlCholesterol']),
      ldlCholesterol: serializer.fromJson<double>(json['ldlCholesterol']),
      triglycerides: serializer.fromJson<double>(json['triglycerides']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'bloodGlucoseMode': serializer.toJson<int>(bloodGlucoseMode),
      'bloodGlucose': serializer.toJson<double>(bloodGlucose),
      'uricAcidMode': serializer.toJson<int>(uricAcidMode),
      'uricAcid': serializer.toJson<int>(uricAcid),
      'bloodKetoneMode': serializer.toJson<int>(bloodKetoneMode),
      'bloodKetone': serializer.toJson<double>(bloodKetone),
      'bloodFatMode': serializer.toJson<int>(bloodFatMode),
      'totalCholesterol': serializer.toJson<double>(totalCholesterol),
      'hdlCholesterol': serializer.toJson<double>(hdlCholesterol),
      'ldlCholesterol': serializer.toJson<double>(ldlCholesterol),
      'triglycerides': serializer.toJson<double>(triglycerides),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  InvasiveComprehensiveDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          int? bloodGlucoseMode,
          double? bloodGlucose,
          int? uricAcidMode,
          int? uricAcid,
          int? bloodKetoneMode,
          double? bloodKetone,
          int? bloodFatMode,
          double? totalCholesterol,
          double? hdlCholesterol,
          double? ldlCholesterol,
          double? triglycerides,
          bool? isSynced}) =>
      InvasiveComprehensiveDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        bloodGlucoseMode: bloodGlucoseMode ?? this.bloodGlucoseMode,
        bloodGlucose: bloodGlucose ?? this.bloodGlucose,
        uricAcidMode: uricAcidMode ?? this.uricAcidMode,
        uricAcid: uricAcid ?? this.uricAcid,
        bloodKetoneMode: bloodKetoneMode ?? this.bloodKetoneMode,
        bloodKetone: bloodKetone ?? this.bloodKetone,
        bloodFatMode: bloodFatMode ?? this.bloodFatMode,
        totalCholesterol: totalCholesterol ?? this.totalCholesterol,
        hdlCholesterol: hdlCholesterol ?? this.hdlCholesterol,
        ldlCholesterol: ldlCholesterol ?? this.ldlCholesterol,
        triglycerides: triglycerides ?? this.triglycerides,
        isSynced: isSynced ?? this.isSynced,
      );
  InvasiveComprehensiveDataData copyWithCompanion(
      InvasiveComprehensiveDataCompanion data) {
    return InvasiveComprehensiveDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      bloodGlucoseMode: data.bloodGlucoseMode.present
          ? data.bloodGlucoseMode.value
          : this.bloodGlucoseMode,
      bloodGlucose: data.bloodGlucose.present
          ? data.bloodGlucose.value
          : this.bloodGlucose,
      uricAcidMode: data.uricAcidMode.present
          ? data.uricAcidMode.value
          : this.uricAcidMode,
      uricAcid: data.uricAcid.present ? data.uricAcid.value : this.uricAcid,
      bloodKetoneMode: data.bloodKetoneMode.present
          ? data.bloodKetoneMode.value
          : this.bloodKetoneMode,
      bloodKetone:
          data.bloodKetone.present ? data.bloodKetone.value : this.bloodKetone,
      bloodFatMode: data.bloodFatMode.present
          ? data.bloodFatMode.value
          : this.bloodFatMode,
      totalCholesterol: data.totalCholesterol.present
          ? data.totalCholesterol.value
          : this.totalCholesterol,
      hdlCholesterol: data.hdlCholesterol.present
          ? data.hdlCholesterol.value
          : this.hdlCholesterol,
      ldlCholesterol: data.ldlCholesterol.present
          ? data.ldlCholesterol.value
          : this.ldlCholesterol,
      triglycerides: data.triglycerides.present
          ? data.triglycerides.value
          : this.triglycerides,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvasiveComprehensiveDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('bloodGlucoseMode: $bloodGlucoseMode, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('uricAcidMode: $uricAcidMode, ')
          ..write('uricAcid: $uricAcid, ')
          ..write('bloodKetoneMode: $bloodKetoneMode, ')
          ..write('bloodKetone: $bloodKetone, ')
          ..write('bloodFatMode: $bloodFatMode, ')
          ..write('totalCholesterol: $totalCholesterol, ')
          ..write('hdlCholesterol: $hdlCholesterol, ')
          ..write('ldlCholesterol: $ldlCholesterol, ')
          ..write('triglycerides: $triglycerides, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      startTimeStamp,
      bloodGlucoseMode,
      bloodGlucose,
      uricAcidMode,
      uricAcid,
      bloodKetoneMode,
      bloodKetone,
      bloodFatMode,
      totalCholesterol,
      hdlCholesterol,
      ldlCholesterol,
      triglycerides,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvasiveComprehensiveDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.bloodGlucoseMode == this.bloodGlucoseMode &&
          other.bloodGlucose == this.bloodGlucose &&
          other.uricAcidMode == this.uricAcidMode &&
          other.uricAcid == this.uricAcid &&
          other.bloodKetoneMode == this.bloodKetoneMode &&
          other.bloodKetone == this.bloodKetone &&
          other.bloodFatMode == this.bloodFatMode &&
          other.totalCholesterol == this.totalCholesterol &&
          other.hdlCholesterol == this.hdlCholesterol &&
          other.ldlCholesterol == this.ldlCholesterol &&
          other.triglycerides == this.triglycerides &&
          other.isSynced == this.isSynced);
}

class InvasiveComprehensiveDataCompanion
    extends UpdateCompanion<InvasiveComprehensiveDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<int> bloodGlucoseMode;
  final Value<double> bloodGlucose;
  final Value<int> uricAcidMode;
  final Value<int> uricAcid;
  final Value<int> bloodKetoneMode;
  final Value<double> bloodKetone;
  final Value<int> bloodFatMode;
  final Value<double> totalCholesterol;
  final Value<double> hdlCholesterol;
  final Value<double> ldlCholesterol;
  final Value<double> triglycerides;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const InvasiveComprehensiveDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.bloodGlucoseMode = const Value.absent(),
    this.bloodGlucose = const Value.absent(),
    this.uricAcidMode = const Value.absent(),
    this.uricAcid = const Value.absent(),
    this.bloodKetoneMode = const Value.absent(),
    this.bloodKetone = const Value.absent(),
    this.bloodFatMode = const Value.absent(),
    this.totalCholesterol = const Value.absent(),
    this.hdlCholesterol = const Value.absent(),
    this.ldlCholesterol = const Value.absent(),
    this.triglycerides = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvasiveComprehensiveDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required int bloodGlucoseMode,
    required double bloodGlucose,
    required int uricAcidMode,
    required int uricAcid,
    required int bloodKetoneMode,
    required double bloodKetone,
    required int bloodFatMode,
    required double totalCholesterol,
    required double hdlCholesterol,
    required double ldlCholesterol,
    required double triglycerides,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        bloodGlucoseMode = Value(bloodGlucoseMode),
        bloodGlucose = Value(bloodGlucose),
        uricAcidMode = Value(uricAcidMode),
        uricAcid = Value(uricAcid),
        bloodKetoneMode = Value(bloodKetoneMode),
        bloodKetone = Value(bloodKetone),
        bloodFatMode = Value(bloodFatMode),
        totalCholesterol = Value(totalCholesterol),
        hdlCholesterol = Value(hdlCholesterol),
        ldlCholesterol = Value(ldlCholesterol),
        triglycerides = Value(triglycerides);
  static Insertable<InvasiveComprehensiveDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<int>? bloodGlucoseMode,
    Expression<double>? bloodGlucose,
    Expression<int>? uricAcidMode,
    Expression<int>? uricAcid,
    Expression<int>? bloodKetoneMode,
    Expression<double>? bloodKetone,
    Expression<int>? bloodFatMode,
    Expression<double>? totalCholesterol,
    Expression<double>? hdlCholesterol,
    Expression<double>? ldlCholesterol,
    Expression<double>? triglycerides,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (bloodGlucoseMode != null) 'blood_glucose_mode': bloodGlucoseMode,
      if (bloodGlucose != null) 'blood_glucose': bloodGlucose,
      if (uricAcidMode != null) 'uric_acid_mode': uricAcidMode,
      if (uricAcid != null) 'uric_acid': uricAcid,
      if (bloodKetoneMode != null) 'blood_ketone_mode': bloodKetoneMode,
      if (bloodKetone != null) 'blood_ketone': bloodKetone,
      if (bloodFatMode != null) 'blood_fat_mode': bloodFatMode,
      if (totalCholesterol != null) 'total_cholesterol': totalCholesterol,
      if (hdlCholesterol != null) 'hdl_cholesterol': hdlCholesterol,
      if (ldlCholesterol != null) 'ldl_cholesterol': ldlCholesterol,
      if (triglycerides != null) 'triglycerides': triglycerides,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvasiveComprehensiveDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<int>? bloodGlucoseMode,
      Value<double>? bloodGlucose,
      Value<int>? uricAcidMode,
      Value<int>? uricAcid,
      Value<int>? bloodKetoneMode,
      Value<double>? bloodKetone,
      Value<int>? bloodFatMode,
      Value<double>? totalCholesterol,
      Value<double>? hdlCholesterol,
      Value<double>? ldlCholesterol,
      Value<double>? triglycerides,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return InvasiveComprehensiveDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      bloodGlucoseMode: bloodGlucoseMode ?? this.bloodGlucoseMode,
      bloodGlucose: bloodGlucose ?? this.bloodGlucose,
      uricAcidMode: uricAcidMode ?? this.uricAcidMode,
      uricAcid: uricAcid ?? this.uricAcid,
      bloodKetoneMode: bloodKetoneMode ?? this.bloodKetoneMode,
      bloodKetone: bloodKetone ?? this.bloodKetone,
      bloodFatMode: bloodFatMode ?? this.bloodFatMode,
      totalCholesterol: totalCholesterol ?? this.totalCholesterol,
      hdlCholesterol: hdlCholesterol ?? this.hdlCholesterol,
      ldlCholesterol: ldlCholesterol ?? this.ldlCholesterol,
      triglycerides: triglycerides ?? this.triglycerides,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (bloodGlucoseMode.present) {
      map['blood_glucose_mode'] = Variable<int>(bloodGlucoseMode.value);
    }
    if (bloodGlucose.present) {
      map['blood_glucose'] = Variable<double>(bloodGlucose.value);
    }
    if (uricAcidMode.present) {
      map['uric_acid_mode'] = Variable<int>(uricAcidMode.value);
    }
    if (uricAcid.present) {
      map['uric_acid'] = Variable<int>(uricAcid.value);
    }
    if (bloodKetoneMode.present) {
      map['blood_ketone_mode'] = Variable<int>(bloodKetoneMode.value);
    }
    if (bloodKetone.present) {
      map['blood_ketone'] = Variable<double>(bloodKetone.value);
    }
    if (bloodFatMode.present) {
      map['blood_fat_mode'] = Variable<int>(bloodFatMode.value);
    }
    if (totalCholesterol.present) {
      map['total_cholesterol'] = Variable<double>(totalCholesterol.value);
    }
    if (hdlCholesterol.present) {
      map['hdl_cholesterol'] = Variable<double>(hdlCholesterol.value);
    }
    if (ldlCholesterol.present) {
      map['ldl_cholesterol'] = Variable<double>(ldlCholesterol.value);
    }
    if (triglycerides.present) {
      map['triglycerides'] = Variable<double>(triglycerides.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvasiveComprehensiveDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('bloodGlucoseMode: $bloodGlucoseMode, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('uricAcidMode: $uricAcidMode, ')
          ..write('uricAcid: $uricAcid, ')
          ..write('bloodKetoneMode: $bloodKetoneMode, ')
          ..write('bloodKetone: $bloodKetone, ')
          ..write('bloodFatMode: $bloodFatMode, ')
          ..write('totalCholesterol: $totalCholesterol, ')
          ..write('hdlCholesterol: $hdlCholesterol, ')
          ..write('ldlCholesterol: $ldlCholesterol, ')
          ..write('triglycerides: $triglycerides, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PressureDataTable extends PressureData
    with TableInfo<$PressureDataTable, PressureDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PressureDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeStampMeta =
      const VerificationMeta('startTimeStamp');
  @override
  late final GeneratedColumn<int> startTimeStamp = GeneratedColumn<int>(
      'start_time_stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalStressScoreMeta =
      const VerificationMeta('totalStressScore');
  @override
  late final GeneratedColumn<double> totalStressScore = GeneratedColumn<double>(
      'total_stress_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stressLevelMeta =
      const VerificationMeta('stressLevel');
  @override
  late final GeneratedColumn<String> stressLevel = GeneratedColumn<String>(
      'stress_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [userId, startTimeStamp, totalStressScore, stressLevel, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pressure_data';
  @override
  VerificationContext validateIntegrity(Insertable<PressureDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_time_stamp')) {
      context.handle(
          _startTimeStampMeta,
          startTimeStamp.isAcceptableOrUnknown(
              data['start_time_stamp']!, _startTimeStampMeta));
    } else if (isInserting) {
      context.missing(_startTimeStampMeta);
    }
    if (data.containsKey('total_stress_score')) {
      context.handle(
          _totalStressScoreMeta,
          totalStressScore.isAcceptableOrUnknown(
              data['total_stress_score']!, _totalStressScoreMeta));
    } else if (isInserting) {
      context.missing(_totalStressScoreMeta);
    }
    if (data.containsKey('stress_level')) {
      context.handle(
          _stressLevelMeta,
          stressLevel.isAcceptableOrUnknown(
              data['stress_level']!, _stressLevelMeta));
    } else if (isInserting) {
      context.missing(_stressLevelMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, startTimeStamp};
  @override
  PressureDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PressureDataData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startTimeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time_stamp'])!,
      totalStressScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_stress_score'])!,
      stressLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stress_level'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $PressureDataTable createAlias(String alias) {
    return $PressureDataTable(attachedDatabase, alias);
  }
}

class PressureDataData extends DataClass
    implements Insertable<PressureDataData> {
  final String userId;
  final int startTimeStamp;
  final double totalStressScore;
  final String stressLevel;
  final bool isSynced;
  const PressureDataData(
      {required this.userId,
      required this.startTimeStamp,
      required this.totalStressScore,
      required this.stressLevel,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['start_time_stamp'] = Variable<int>(startTimeStamp);
    map['total_stress_score'] = Variable<double>(totalStressScore);
    map['stress_level'] = Variable<String>(stressLevel);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PressureDataCompanion toCompanion(bool nullToAbsent) {
    return PressureDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      totalStressScore: Value(totalStressScore),
      stressLevel: Value(stressLevel),
      isSynced: Value(isSynced),
    );
  }

  factory PressureDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PressureDataData(
      userId: serializer.fromJson<String>(json['userId']),
      startTimeStamp: serializer.fromJson<int>(json['startTimeStamp']),
      totalStressScore: serializer.fromJson<double>(json['totalStressScore']),
      stressLevel: serializer.fromJson<String>(json['stressLevel']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'startTimeStamp': serializer.toJson<int>(startTimeStamp),
      'totalStressScore': serializer.toJson<double>(totalStressScore),
      'stressLevel': serializer.toJson<String>(stressLevel),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PressureDataData copyWith(
          {String? userId,
          int? startTimeStamp,
          double? totalStressScore,
          String? stressLevel,
          bool? isSynced}) =>
      PressureDataData(
        userId: userId ?? this.userId,
        startTimeStamp: startTimeStamp ?? this.startTimeStamp,
        totalStressScore: totalStressScore ?? this.totalStressScore,
        stressLevel: stressLevel ?? this.stressLevel,
        isSynced: isSynced ?? this.isSynced,
      );
  PressureDataData copyWithCompanion(PressureDataCompanion data) {
    return PressureDataData(
      userId: data.userId.present ? data.userId.value : this.userId,
      startTimeStamp: data.startTimeStamp.present
          ? data.startTimeStamp.value
          : this.startTimeStamp,
      totalStressScore: data.totalStressScore.present
          ? data.totalStressScore.value
          : this.totalStressScore,
      stressLevel:
          data.stressLevel.present ? data.stressLevel.value : this.stressLevel,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PressureDataData(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('totalStressScore: $totalStressScore, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId, startTimeStamp, totalStressScore, stressLevel, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PressureDataData &&
          other.userId == this.userId &&
          other.startTimeStamp == this.startTimeStamp &&
          other.totalStressScore == this.totalStressScore &&
          other.stressLevel == this.stressLevel &&
          other.isSynced == this.isSynced);
}

class PressureDataCompanion extends UpdateCompanion<PressureDataData> {
  final Value<String> userId;
  final Value<int> startTimeStamp;
  final Value<double> totalStressScore;
  final Value<String> stressLevel;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const PressureDataCompanion({
    this.userId = const Value.absent(),
    this.startTimeStamp = const Value.absent(),
    this.totalStressScore = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PressureDataCompanion.insert({
    required String userId,
    required int startTimeStamp,
    required double totalStressScore,
    required String stressLevel,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        startTimeStamp = Value(startTimeStamp),
        totalStressScore = Value(totalStressScore),
        stressLevel = Value(stressLevel);
  static Insertable<PressureDataData> custom({
    Expression<String>? userId,
    Expression<int>? startTimeStamp,
    Expression<double>? totalStressScore,
    Expression<String>? stressLevel,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (startTimeStamp != null) 'start_time_stamp': startTimeStamp,
      if (totalStressScore != null) 'total_stress_score': totalStressScore,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PressureDataCompanion copyWith(
      {Value<String>? userId,
      Value<int>? startTimeStamp,
      Value<double>? totalStressScore,
      Value<String>? stressLevel,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return PressureDataCompanion(
      userId: userId ?? this.userId,
      startTimeStamp: startTimeStamp ?? this.startTimeStamp,
      totalStressScore: totalStressScore ?? this.totalStressScore,
      stressLevel: stressLevel ?? this.stressLevel,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startTimeStamp.present) {
      map['start_time_stamp'] = Variable<int>(startTimeStamp.value);
    }
    if (totalStressScore.present) {
      map['total_stress_score'] = Variable<double>(totalStressScore.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<String>(stressLevel.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PressureDataCompanion(')
          ..write('userId: $userId, ')
          ..write('startTimeStamp: $startTimeStamp, ')
          ..write('totalStressScore: $totalStressScore, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StepDataTable stepData = $StepDataTable(this);
  late final $SleepDataTable sleepData = $SleepDataTable(this);
  late final $SleepDetailDataTable sleepDetailData =
      $SleepDetailDataTable(this);
  late final $HeartRateDataTable heartRateData = $HeartRateDataTable(this);
  late final $BloodPressureDataTable bloodPressureData =
      $BloodPressureDataTable(this);
  late final $CombinedDataTable combinedData = $CombinedDataTable(this);
  late final $InvasiveComprehensiveDataTable invasiveComprehensiveData =
      $InvasiveComprehensiveDataTable(this);
  late final $PressureDataTable pressureData = $PressureDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        stepData,
        sleepData,
        sleepDetailData,
        heartRateData,
        bloodPressureData,
        combinedData,
        invasiveComprehensiveData,
        pressureData
      ];
}

typedef $$StepDataTableCreateCompanionBuilder = StepDataCompanion Function({
  required String userId,
  required int startTimeStamp,
  required int endTimeStamp,
  required int step,
  required int distance,
  required int calories,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$StepDataTableUpdateCompanionBuilder = StepDataCompanion Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> endTimeStamp,
  Value<int> step,
  Value<int> distance,
  Value<int> calories,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$StepDataTableFilterComposer
    extends Composer<_$AppDatabase, $StepDataTable> {
  $$StepDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get step => $composableBuilder(
      column: $table.step, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$StepDataTableOrderingComposer
    extends Composer<_$AppDatabase, $StepDataTable> {
  $$StepDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get step => $composableBuilder(
      column: $table.step, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$StepDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepDataTable> {
  $$StepDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<int> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$StepDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StepDataTable,
    StepDataData,
    $$StepDataTableFilterComposer,
    $$StepDataTableOrderingComposer,
    $$StepDataTableAnnotationComposer,
    $$StepDataTableCreateCompanionBuilder,
    $$StepDataTableUpdateCompanionBuilder,
    (StepDataData, BaseReferences<_$AppDatabase, $StepDataTable, StepDataData>),
    StepDataData,
    PrefetchHooks Function()> {
  $$StepDataTableTableManager(_$AppDatabase db, $StepDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> endTimeStamp = const Value.absent(),
            Value<int> step = const Value.absent(),
            Value<int> distance = const Value.absent(),
            Value<int> calories = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StepDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp,
            step: step,
            distance: distance,
            calories: calories,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int endTimeStamp,
            required int step,
            required int distance,
            required int calories,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StepDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp,
            step: step,
            distance: distance,
            calories: calories,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StepDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StepDataTable,
    StepDataData,
    $$StepDataTableFilterComposer,
    $$StepDataTableOrderingComposer,
    $$StepDataTableAnnotationComposer,
    $$StepDataTableCreateCompanionBuilder,
    $$StepDataTableUpdateCompanionBuilder,
    (StepDataData, BaseReferences<_$AppDatabase, $StepDataTable, StepDataData>),
    StepDataData,
    PrefetchHooks Function()>;
typedef $$SleepDataTableCreateCompanionBuilder = SleepDataCompanion Function({
  required String userId,
  required int startTimeStamp,
  required int endTimeStamp,
  required int deepSleepSeconds,
  required int lightSleepSeconds,
  required int remSleepSeconds,
  Value<bool> isNewSleepProtocol,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$SleepDataTableUpdateCompanionBuilder = SleepDataCompanion Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> endTimeStamp,
  Value<int> deepSleepSeconds,
  Value<int> lightSleepSeconds,
  Value<int> remSleepSeconds,
  Value<bool> isNewSleepProtocol,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$SleepDataTableFilterComposer
    extends Composer<_$AppDatabase, $SleepDataTable> {
  $$SleepDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deepSleepSeconds => $composableBuilder(
      column: $table.deepSleepSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lightSleepSeconds => $composableBuilder(
      column: $table.lightSleepSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remSleepSeconds => $composableBuilder(
      column: $table.remSleepSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isNewSleepProtocol => $composableBuilder(
      column: $table.isNewSleepProtocol,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$SleepDataTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepDataTable> {
  $$SleepDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deepSleepSeconds => $composableBuilder(
      column: $table.deepSleepSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lightSleepSeconds => $composableBuilder(
      column: $table.lightSleepSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remSleepSeconds => $composableBuilder(
      column: $table.remSleepSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isNewSleepProtocol => $composableBuilder(
      column: $table.isNewSleepProtocol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$SleepDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepDataTable> {
  $$SleepDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get endTimeStamp => $composableBuilder(
      column: $table.endTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get deepSleepSeconds => $composableBuilder(
      column: $table.deepSleepSeconds, builder: (column) => column);

  GeneratedColumn<int> get lightSleepSeconds => $composableBuilder(
      column: $table.lightSleepSeconds, builder: (column) => column);

  GeneratedColumn<int> get remSleepSeconds => $composableBuilder(
      column: $table.remSleepSeconds, builder: (column) => column);

  GeneratedColumn<bool> get isNewSleepProtocol => $composableBuilder(
      column: $table.isNewSleepProtocol, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$SleepDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SleepDataTable,
    SleepDataData,
    $$SleepDataTableFilterComposer,
    $$SleepDataTableOrderingComposer,
    $$SleepDataTableAnnotationComposer,
    $$SleepDataTableCreateCompanionBuilder,
    $$SleepDataTableUpdateCompanionBuilder,
    (
      SleepDataData,
      BaseReferences<_$AppDatabase, $SleepDataTable, SleepDataData>
    ),
    SleepDataData,
    PrefetchHooks Function()> {
  $$SleepDataTableTableManager(_$AppDatabase db, $SleepDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> endTimeStamp = const Value.absent(),
            Value<int> deepSleepSeconds = const Value.absent(),
            Value<int> lightSleepSeconds = const Value.absent(),
            Value<int> remSleepSeconds = const Value.absent(),
            Value<bool> isNewSleepProtocol = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp,
            deepSleepSeconds: deepSleepSeconds,
            lightSleepSeconds: lightSleepSeconds,
            remSleepSeconds: remSleepSeconds,
            isNewSleepProtocol: isNewSleepProtocol,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int endTimeStamp,
            required int deepSleepSeconds,
            required int lightSleepSeconds,
            required int remSleepSeconds,
            Value<bool> isNewSleepProtocol = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp,
            deepSleepSeconds: deepSleepSeconds,
            lightSleepSeconds: lightSleepSeconds,
            remSleepSeconds: remSleepSeconds,
            isNewSleepProtocol: isNewSleepProtocol,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SleepDataTable,
    SleepDataData,
    $$SleepDataTableFilterComposer,
    $$SleepDataTableOrderingComposer,
    $$SleepDataTableAnnotationComposer,
    $$SleepDataTableCreateCompanionBuilder,
    $$SleepDataTableUpdateCompanionBuilder,
    (
      SleepDataData,
      BaseReferences<_$AppDatabase, $SleepDataTable, SleepDataData>
    ),
    SleepDataData,
    PrefetchHooks Function()>;
typedef $$SleepDetailDataTableCreateCompanionBuilder = SleepDetailDataCompanion
    Function({
  required String userId,
  required int sleepStartTimeStamp,
  required int startTimeStamp,
  required int duration,
  required int sleepType,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$SleepDetailDataTableUpdateCompanionBuilder = SleepDetailDataCompanion
    Function({
  Value<String> userId,
  Value<int> sleepStartTimeStamp,
  Value<int> startTimeStamp,
  Value<int> duration,
  Value<int> sleepType,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$SleepDetailDataTableFilterComposer
    extends Composer<_$AppDatabase, $SleepDetailDataTable> {
  $$SleepDetailDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepStartTimeStamp => $composableBuilder(
      column: $table.sleepStartTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepType => $composableBuilder(
      column: $table.sleepType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$SleepDetailDataTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepDetailDataTable> {
  $$SleepDetailDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepStartTimeStamp => $composableBuilder(
      column: $table.sleepStartTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepType => $composableBuilder(
      column: $table.sleepType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$SleepDetailDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepDetailDataTable> {
  $$SleepDetailDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get sleepStartTimeStamp => $composableBuilder(
      column: $table.sleepStartTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get sleepType =>
      $composableBuilder(column: $table.sleepType, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$SleepDetailDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SleepDetailDataTable,
    SleepDetailDataData,
    $$SleepDetailDataTableFilterComposer,
    $$SleepDetailDataTableOrderingComposer,
    $$SleepDetailDataTableAnnotationComposer,
    $$SleepDetailDataTableCreateCompanionBuilder,
    $$SleepDetailDataTableUpdateCompanionBuilder,
    (
      SleepDetailDataData,
      BaseReferences<_$AppDatabase, $SleepDetailDataTable, SleepDetailDataData>
    ),
    SleepDetailDataData,
    PrefetchHooks Function()> {
  $$SleepDetailDataTableTableManager(
      _$AppDatabase db, $SleepDetailDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepDetailDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepDetailDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepDetailDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> sleepStartTimeStamp = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<int> sleepType = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepDetailDataCompanion(
            userId: userId,
            sleepStartTimeStamp: sleepStartTimeStamp,
            startTimeStamp: startTimeStamp,
            duration: duration,
            sleepType: sleepType,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int sleepStartTimeStamp,
            required int startTimeStamp,
            required int duration,
            required int sleepType,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepDetailDataCompanion.insert(
            userId: userId,
            sleepStartTimeStamp: sleepStartTimeStamp,
            startTimeStamp: startTimeStamp,
            duration: duration,
            sleepType: sleepType,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepDetailDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SleepDetailDataTable,
    SleepDetailDataData,
    $$SleepDetailDataTableFilterComposer,
    $$SleepDetailDataTableOrderingComposer,
    $$SleepDetailDataTableAnnotationComposer,
    $$SleepDetailDataTableCreateCompanionBuilder,
    $$SleepDetailDataTableUpdateCompanionBuilder,
    (
      SleepDetailDataData,
      BaseReferences<_$AppDatabase, $SleepDetailDataTable, SleepDetailDataData>
    ),
    SleepDetailDataData,
    PrefetchHooks Function()>;
typedef $$HeartRateDataTableCreateCompanionBuilder = HeartRateDataCompanion
    Function({
  required String userId,
  required int startTimeStamp,
  required int heartRate,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$HeartRateDataTableUpdateCompanionBuilder = HeartRateDataCompanion
    Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> heartRate,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$HeartRateDataTableFilterComposer
    extends Composer<_$AppDatabase, $HeartRateDataTable> {
  $$HeartRateDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$HeartRateDataTableOrderingComposer
    extends Composer<_$AppDatabase, $HeartRateDataTable> {
  $$HeartRateDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$HeartRateDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $HeartRateDataTable> {
  $$HeartRateDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$HeartRateDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HeartRateDataTable,
    HeartRateDataData,
    $$HeartRateDataTableFilterComposer,
    $$HeartRateDataTableOrderingComposer,
    $$HeartRateDataTableAnnotationComposer,
    $$HeartRateDataTableCreateCompanionBuilder,
    $$HeartRateDataTableUpdateCompanionBuilder,
    (
      HeartRateDataData,
      BaseReferences<_$AppDatabase, $HeartRateDataTable, HeartRateDataData>
    ),
    HeartRateDataData,
    PrefetchHooks Function()> {
  $$HeartRateDataTableTableManager(_$AppDatabase db, $HeartRateDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HeartRateDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HeartRateDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HeartRateDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> heartRate = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HeartRateDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            heartRate: heartRate,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int heartRate,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HeartRateDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            heartRate: heartRate,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HeartRateDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HeartRateDataTable,
    HeartRateDataData,
    $$HeartRateDataTableFilterComposer,
    $$HeartRateDataTableOrderingComposer,
    $$HeartRateDataTableAnnotationComposer,
    $$HeartRateDataTableCreateCompanionBuilder,
    $$HeartRateDataTableUpdateCompanionBuilder,
    (
      HeartRateDataData,
      BaseReferences<_$AppDatabase, $HeartRateDataTable, HeartRateDataData>
    ),
    HeartRateDataData,
    PrefetchHooks Function()>;
typedef $$BloodPressureDataTableCreateCompanionBuilder
    = BloodPressureDataCompanion Function({
  required String userId,
  required int startTimeStamp,
  required int systolicBloodPressure,
  required int diastolicBloodPressure,
  required int mode,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$BloodPressureDataTableUpdateCompanionBuilder
    = BloodPressureDataCompanion Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> systolicBloodPressure,
  Value<int> diastolicBloodPressure,
  Value<int> mode,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$BloodPressureDataTableFilterComposer
    extends Composer<_$AppDatabase, $BloodPressureDataTable> {
  $$BloodPressureDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$BloodPressureDataTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodPressureDataTable> {
  $$BloodPressureDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$BloodPressureDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodPressureDataTable> {
  $$BloodPressureDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure, builder: (column) => column);

  GeneratedColumn<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure, builder: (column) => column);

  GeneratedColumn<int> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$BloodPressureDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BloodPressureDataTable,
    BloodPressureDataData,
    $$BloodPressureDataTableFilterComposer,
    $$BloodPressureDataTableOrderingComposer,
    $$BloodPressureDataTableAnnotationComposer,
    $$BloodPressureDataTableCreateCompanionBuilder,
    $$BloodPressureDataTableUpdateCompanionBuilder,
    (
      BloodPressureDataData,
      BaseReferences<_$AppDatabase, $BloodPressureDataTable,
          BloodPressureDataData>
    ),
    BloodPressureDataData,
    PrefetchHooks Function()> {
  $$BloodPressureDataTableTableManager(
      _$AppDatabase db, $BloodPressureDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodPressureDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodPressureDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodPressureDataTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> systolicBloodPressure = const Value.absent(),
            Value<int> diastolicBloodPressure = const Value.absent(),
            Value<int> mode = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BloodPressureDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            systolicBloodPressure: systolicBloodPressure,
            diastolicBloodPressure: diastolicBloodPressure,
            mode: mode,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int systolicBloodPressure,
            required int diastolicBloodPressure,
            required int mode,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BloodPressureDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            systolicBloodPressure: systolicBloodPressure,
            diastolicBloodPressure: diastolicBloodPressure,
            mode: mode,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BloodPressureDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BloodPressureDataTable,
    BloodPressureDataData,
    $$BloodPressureDataTableFilterComposer,
    $$BloodPressureDataTableOrderingComposer,
    $$BloodPressureDataTableAnnotationComposer,
    $$BloodPressureDataTableCreateCompanionBuilder,
    $$BloodPressureDataTableUpdateCompanionBuilder,
    (
      BloodPressureDataData,
      BaseReferences<_$AppDatabase, $BloodPressureDataTable,
          BloodPressureDataData>
    ),
    BloodPressureDataData,
    PrefetchHooks Function()>;
typedef $$CombinedDataTableCreateCompanionBuilder = CombinedDataCompanion
    Function({
  required String userId,
  required int startTimeStamp,
  required int step,
  required int heartRate,
  required int systolicBloodPressure,
  required int diastolicBloodPressure,
  required int bloodOxygen,
  required int respirationRate,
  required int hrv,
  required int cvrr,
  required double bloodGlucose,
  required double fat,
  required double temperature,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$CombinedDataTableUpdateCompanionBuilder = CombinedDataCompanion
    Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> step,
  Value<int> heartRate,
  Value<int> systolicBloodPressure,
  Value<int> diastolicBloodPressure,
  Value<int> bloodOxygen,
  Value<int> respirationRate,
  Value<int> hrv,
  Value<int> cvrr,
  Value<double> bloodGlucose,
  Value<double> fat,
  Value<double> temperature,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$CombinedDataTableFilterComposer
    extends Composer<_$AppDatabase, $CombinedDataTable> {
  $$CombinedDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get step => $composableBuilder(
      column: $table.step, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodOxygen => $composableBuilder(
      column: $table.bloodOxygen, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get respirationRate => $composableBuilder(
      column: $table.respirationRate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hrv => $composableBuilder(
      column: $table.hrv, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cvrr => $composableBuilder(
      column: $table.cvrr, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$CombinedDataTableOrderingComposer
    extends Composer<_$AppDatabase, $CombinedDataTable> {
  $$CombinedDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get step => $composableBuilder(
      column: $table.step, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodOxygen => $composableBuilder(
      column: $table.bloodOxygen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get respirationRate => $composableBuilder(
      column: $table.respirationRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hrv => $composableBuilder(
      column: $table.hrv, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cvrr => $composableBuilder(
      column: $table.cvrr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$CombinedDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $CombinedDataTable> {
  $$CombinedDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<int> get systolicBloodPressure => $composableBuilder(
      column: $table.systolicBloodPressure, builder: (column) => column);

  GeneratedColumn<int> get diastolicBloodPressure => $composableBuilder(
      column: $table.diastolicBloodPressure, builder: (column) => column);

  GeneratedColumn<int> get bloodOxygen => $composableBuilder(
      column: $table.bloodOxygen, builder: (column) => column);

  GeneratedColumn<int> get respirationRate => $composableBuilder(
      column: $table.respirationRate, builder: (column) => column);

  GeneratedColumn<int> get hrv =>
      $composableBuilder(column: $table.hrv, builder: (column) => column);

  GeneratedColumn<int> get cvrr =>
      $composableBuilder(column: $table.cvrr, builder: (column) => column);

  GeneratedColumn<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$CombinedDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CombinedDataTable,
    CombinedDataData,
    $$CombinedDataTableFilterComposer,
    $$CombinedDataTableOrderingComposer,
    $$CombinedDataTableAnnotationComposer,
    $$CombinedDataTableCreateCompanionBuilder,
    $$CombinedDataTableUpdateCompanionBuilder,
    (
      CombinedDataData,
      BaseReferences<_$AppDatabase, $CombinedDataTable, CombinedDataData>
    ),
    CombinedDataData,
    PrefetchHooks Function()> {
  $$CombinedDataTableTableManager(_$AppDatabase db, $CombinedDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CombinedDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CombinedDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CombinedDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> step = const Value.absent(),
            Value<int> heartRate = const Value.absent(),
            Value<int> systolicBloodPressure = const Value.absent(),
            Value<int> diastolicBloodPressure = const Value.absent(),
            Value<int> bloodOxygen = const Value.absent(),
            Value<int> respirationRate = const Value.absent(),
            Value<int> hrv = const Value.absent(),
            Value<int> cvrr = const Value.absent(),
            Value<double> bloodGlucose = const Value.absent(),
            Value<double> fat = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CombinedDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            step: step,
            heartRate: heartRate,
            systolicBloodPressure: systolicBloodPressure,
            diastolicBloodPressure: diastolicBloodPressure,
            bloodOxygen: bloodOxygen,
            respirationRate: respirationRate,
            hrv: hrv,
            cvrr: cvrr,
            bloodGlucose: bloodGlucose,
            fat: fat,
            temperature: temperature,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int step,
            required int heartRate,
            required int systolicBloodPressure,
            required int diastolicBloodPressure,
            required int bloodOxygen,
            required int respirationRate,
            required int hrv,
            required int cvrr,
            required double bloodGlucose,
            required double fat,
            required double temperature,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CombinedDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            step: step,
            heartRate: heartRate,
            systolicBloodPressure: systolicBloodPressure,
            diastolicBloodPressure: diastolicBloodPressure,
            bloodOxygen: bloodOxygen,
            respirationRate: respirationRate,
            hrv: hrv,
            cvrr: cvrr,
            bloodGlucose: bloodGlucose,
            fat: fat,
            temperature: temperature,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CombinedDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CombinedDataTable,
    CombinedDataData,
    $$CombinedDataTableFilterComposer,
    $$CombinedDataTableOrderingComposer,
    $$CombinedDataTableAnnotationComposer,
    $$CombinedDataTableCreateCompanionBuilder,
    $$CombinedDataTableUpdateCompanionBuilder,
    (
      CombinedDataData,
      BaseReferences<_$AppDatabase, $CombinedDataTable, CombinedDataData>
    ),
    CombinedDataData,
    PrefetchHooks Function()>;
typedef $$InvasiveComprehensiveDataTableCreateCompanionBuilder
    = InvasiveComprehensiveDataCompanion Function({
  required String userId,
  required int startTimeStamp,
  required int bloodGlucoseMode,
  required double bloodGlucose,
  required int uricAcidMode,
  required int uricAcid,
  required int bloodKetoneMode,
  required double bloodKetone,
  required int bloodFatMode,
  required double totalCholesterol,
  required double hdlCholesterol,
  required double ldlCholesterol,
  required double triglycerides,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$InvasiveComprehensiveDataTableUpdateCompanionBuilder
    = InvasiveComprehensiveDataCompanion Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<int> bloodGlucoseMode,
  Value<double> bloodGlucose,
  Value<int> uricAcidMode,
  Value<int> uricAcid,
  Value<int> bloodKetoneMode,
  Value<double> bloodKetone,
  Value<int> bloodFatMode,
  Value<double> totalCholesterol,
  Value<double> hdlCholesterol,
  Value<double> ldlCholesterol,
  Value<double> triglycerides,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$InvasiveComprehensiveDataTableFilterComposer
    extends Composer<_$AppDatabase, $InvasiveComprehensiveDataTable> {
  $$InvasiveComprehensiveDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodGlucoseMode => $composableBuilder(
      column: $table.bloodGlucoseMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get uricAcidMode => $composableBuilder(
      column: $table.uricAcidMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get uricAcid => $composableBuilder(
      column: $table.uricAcid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodKetoneMode => $composableBuilder(
      column: $table.bloodKetoneMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bloodKetone => $composableBuilder(
      column: $table.bloodKetone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodFatMode => $composableBuilder(
      column: $table.bloodFatMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCholesterol => $composableBuilder(
      column: $table.totalCholesterol,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hdlCholesterol => $composableBuilder(
      column: $table.hdlCholesterol,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ldlCholesterol => $composableBuilder(
      column: $table.ldlCholesterol,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get triglycerides => $composableBuilder(
      column: $table.triglycerides, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$InvasiveComprehensiveDataTableOrderingComposer
    extends Composer<_$AppDatabase, $InvasiveComprehensiveDataTable> {
  $$InvasiveComprehensiveDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodGlucoseMode => $composableBuilder(
      column: $table.bloodGlucoseMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uricAcidMode => $composableBuilder(
      column: $table.uricAcidMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uricAcid => $composableBuilder(
      column: $table.uricAcid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodKetoneMode => $composableBuilder(
      column: $table.bloodKetoneMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bloodKetone => $composableBuilder(
      column: $table.bloodKetone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodFatMode => $composableBuilder(
      column: $table.bloodFatMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCholesterol => $composableBuilder(
      column: $table.totalCholesterol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hdlCholesterol => $composableBuilder(
      column: $table.hdlCholesterol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ldlCholesterol => $composableBuilder(
      column: $table.ldlCholesterol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get triglycerides => $composableBuilder(
      column: $table.triglycerides,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$InvasiveComprehensiveDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvasiveComprehensiveDataTable> {
  $$InvasiveComprehensiveDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<int> get bloodGlucoseMode => $composableBuilder(
      column: $table.bloodGlucoseMode, builder: (column) => column);

  GeneratedColumn<double> get bloodGlucose => $composableBuilder(
      column: $table.bloodGlucose, builder: (column) => column);

  GeneratedColumn<int> get uricAcidMode => $composableBuilder(
      column: $table.uricAcidMode, builder: (column) => column);

  GeneratedColumn<int> get uricAcid =>
      $composableBuilder(column: $table.uricAcid, builder: (column) => column);

  GeneratedColumn<int> get bloodKetoneMode => $composableBuilder(
      column: $table.bloodKetoneMode, builder: (column) => column);

  GeneratedColumn<double> get bloodKetone => $composableBuilder(
      column: $table.bloodKetone, builder: (column) => column);

  GeneratedColumn<int> get bloodFatMode => $composableBuilder(
      column: $table.bloodFatMode, builder: (column) => column);

  GeneratedColumn<double> get totalCholesterol => $composableBuilder(
      column: $table.totalCholesterol, builder: (column) => column);

  GeneratedColumn<double> get hdlCholesterol => $composableBuilder(
      column: $table.hdlCholesterol, builder: (column) => column);

  GeneratedColumn<double> get ldlCholesterol => $composableBuilder(
      column: $table.ldlCholesterol, builder: (column) => column);

  GeneratedColumn<double> get triglycerides => $composableBuilder(
      column: $table.triglycerides, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$InvasiveComprehensiveDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvasiveComprehensiveDataTable,
    InvasiveComprehensiveDataData,
    $$InvasiveComprehensiveDataTableFilterComposer,
    $$InvasiveComprehensiveDataTableOrderingComposer,
    $$InvasiveComprehensiveDataTableAnnotationComposer,
    $$InvasiveComprehensiveDataTableCreateCompanionBuilder,
    $$InvasiveComprehensiveDataTableUpdateCompanionBuilder,
    (
      InvasiveComprehensiveDataData,
      BaseReferences<_$AppDatabase, $InvasiveComprehensiveDataTable,
          InvasiveComprehensiveDataData>
    ),
    InvasiveComprehensiveDataData,
    PrefetchHooks Function()> {
  $$InvasiveComprehensiveDataTableTableManager(
      _$AppDatabase db, $InvasiveComprehensiveDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvasiveComprehensiveDataTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$InvasiveComprehensiveDataTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvasiveComprehensiveDataTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<int> bloodGlucoseMode = const Value.absent(),
            Value<double> bloodGlucose = const Value.absent(),
            Value<int> uricAcidMode = const Value.absent(),
            Value<int> uricAcid = const Value.absent(),
            Value<int> bloodKetoneMode = const Value.absent(),
            Value<double> bloodKetone = const Value.absent(),
            Value<int> bloodFatMode = const Value.absent(),
            Value<double> totalCholesterol = const Value.absent(),
            Value<double> hdlCholesterol = const Value.absent(),
            Value<double> ldlCholesterol = const Value.absent(),
            Value<double> triglycerides = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InvasiveComprehensiveDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            bloodGlucoseMode: bloodGlucoseMode,
            bloodGlucose: bloodGlucose,
            uricAcidMode: uricAcidMode,
            uricAcid: uricAcid,
            bloodKetoneMode: bloodKetoneMode,
            bloodKetone: bloodKetone,
            bloodFatMode: bloodFatMode,
            totalCholesterol: totalCholesterol,
            hdlCholesterol: hdlCholesterol,
            ldlCholesterol: ldlCholesterol,
            triglycerides: triglycerides,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required int bloodGlucoseMode,
            required double bloodGlucose,
            required int uricAcidMode,
            required int uricAcid,
            required int bloodKetoneMode,
            required double bloodKetone,
            required int bloodFatMode,
            required double totalCholesterol,
            required double hdlCholesterol,
            required double ldlCholesterol,
            required double triglycerides,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InvasiveComprehensiveDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            bloodGlucoseMode: bloodGlucoseMode,
            bloodGlucose: bloodGlucose,
            uricAcidMode: uricAcidMode,
            uricAcid: uricAcid,
            bloodKetoneMode: bloodKetoneMode,
            bloodKetone: bloodKetone,
            bloodFatMode: bloodFatMode,
            totalCholesterol: totalCholesterol,
            hdlCholesterol: hdlCholesterol,
            ldlCholesterol: ldlCholesterol,
            triglycerides: triglycerides,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InvasiveComprehensiveDataTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $InvasiveComprehensiveDataTable,
        InvasiveComprehensiveDataData,
        $$InvasiveComprehensiveDataTableFilterComposer,
        $$InvasiveComprehensiveDataTableOrderingComposer,
        $$InvasiveComprehensiveDataTableAnnotationComposer,
        $$InvasiveComprehensiveDataTableCreateCompanionBuilder,
        $$InvasiveComprehensiveDataTableUpdateCompanionBuilder,
        (
          InvasiveComprehensiveDataData,
          BaseReferences<_$AppDatabase, $InvasiveComprehensiveDataTable,
              InvasiveComprehensiveDataData>
        ),
        InvasiveComprehensiveDataData,
        PrefetchHooks Function()>;
typedef $$PressureDataTableCreateCompanionBuilder = PressureDataCompanion
    Function({
  required String userId,
  required int startTimeStamp,
  required double totalStressScore,
  required String stressLevel,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$PressureDataTableUpdateCompanionBuilder = PressureDataCompanion
    Function({
  Value<String> userId,
  Value<int> startTimeStamp,
  Value<double> totalStressScore,
  Value<String> stressLevel,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$PressureDataTableFilterComposer
    extends Composer<_$AppDatabase, $PressureDataTable> {
  $$PressureDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalStressScore => $composableBuilder(
      column: $table.totalStressScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$PressureDataTableOrderingComposer
    extends Composer<_$AppDatabase, $PressureDataTable> {
  $$PressureDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalStressScore => $composableBuilder(
      column: $table.totalStressScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$PressureDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $PressureDataTable> {
  $$PressureDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get startTimeStamp => $composableBuilder(
      column: $table.startTimeStamp, builder: (column) => column);

  GeneratedColumn<double> get totalStressScore => $composableBuilder(
      column: $table.totalStressScore, builder: (column) => column);

  GeneratedColumn<String> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$PressureDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PressureDataTable,
    PressureDataData,
    $$PressureDataTableFilterComposer,
    $$PressureDataTableOrderingComposer,
    $$PressureDataTableAnnotationComposer,
    $$PressureDataTableCreateCompanionBuilder,
    $$PressureDataTableUpdateCompanionBuilder,
    (
      PressureDataData,
      BaseReferences<_$AppDatabase, $PressureDataTable, PressureDataData>
    ),
    PressureDataData,
    PrefetchHooks Function()> {
  $$PressureDataTableTableManager(_$AppDatabase db, $PressureDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PressureDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PressureDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PressureDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> startTimeStamp = const Value.absent(),
            Value<double> totalStressScore = const Value.absent(),
            Value<String> stressLevel = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PressureDataCompanion(
            userId: userId,
            startTimeStamp: startTimeStamp,
            totalStressScore: totalStressScore,
            stressLevel: stressLevel,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required int startTimeStamp,
            required double totalStressScore,
            required String stressLevel,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PressureDataCompanion.insert(
            userId: userId,
            startTimeStamp: startTimeStamp,
            totalStressScore: totalStressScore,
            stressLevel: stressLevel,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PressureDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PressureDataTable,
    PressureDataData,
    $$PressureDataTableFilterComposer,
    $$PressureDataTableOrderingComposer,
    $$PressureDataTableAnnotationComposer,
    $$PressureDataTableCreateCompanionBuilder,
    $$PressureDataTableUpdateCompanionBuilder,
    (
      PressureDataData,
      BaseReferences<_$AppDatabase, $PressureDataTable, PressureDataData>
    ),
    PressureDataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StepDataTableTableManager get stepData =>
      $$StepDataTableTableManager(_db, _db.stepData);
  $$SleepDataTableTableManager get sleepData =>
      $$SleepDataTableTableManager(_db, _db.sleepData);
  $$SleepDetailDataTableTableManager get sleepDetailData =>
      $$SleepDetailDataTableTableManager(_db, _db.sleepDetailData);
  $$HeartRateDataTableTableManager get heartRateData =>
      $$HeartRateDataTableTableManager(_db, _db.heartRateData);
  $$BloodPressureDataTableTableManager get bloodPressureData =>
      $$BloodPressureDataTableTableManager(_db, _db.bloodPressureData);
  $$CombinedDataTableTableManager get combinedData =>
      $$CombinedDataTableTableManager(_db, _db.combinedData);
  $$InvasiveComprehensiveDataTableTableManager get invasiveComprehensiveData =>
      $$InvasiveComprehensiveDataTableTableManager(
          _db, _db.invasiveComprehensiveData);
  $$PressureDataTableTableManager get pressureData =>
      $$PressureDataTableTableManager(_db, _db.pressureData);
}
