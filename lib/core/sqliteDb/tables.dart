import 'package:drift/drift.dart';

/// 步數資料表
class StepData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get endTimeStamp => integer()();
  IntColumn get step => integer()();
  IntColumn get distance => integer()();
  IntColumn get calories => integer()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

/// 睡眠資料表
class SleepData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get endTimeStamp => integer()();
  IntColumn get deepSleepSeconds => integer()();
  IntColumn get lightSleepSeconds => integer()();
  IntColumn get remSleepSeconds => integer()();
  BoolColumn get isNewSleepProtocol =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

/// 睡眠詳細資料
class SleepDetailData extends Table {
  TextColumn get userId => text()(); // 關聯用
  IntColumn get sleepStartTimeStamp =>
      integer()(); // 關聯到 SleepData 的 startTimeStamp
  IntColumn get startTimeStamp => integer()();
  IntColumn get duration => integer()();
  IntColumn get sleepType => integer()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, sleepStartTimeStamp, startTimeStamp};
}

/// 心率資料表
class HeartRateData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get heartRate => integer()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

/// 血壓資料表
class BloodPressureData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get systolicBloodPressure => integer()();
  IntColumn get diastolicBloodPressure => integer()();
  IntColumn get mode => integer()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

/// 綜合數據資料表
class CombinedData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get step => integer()();
  IntColumn get heartRate => integer()();
  IntColumn get systolicBloodPressure => integer()();
  IntColumn get diastolicBloodPressure => integer()();
  IntColumn get bloodOxygen => integer()();
  IntColumn get respirationRate => integer()();
  IntColumn get hrv => integer()();
  IntColumn get cvrr => integer()();
  RealColumn get bloodGlucose => real()();
  RealColumn get fat => real()();
  RealColumn get temperature => real()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

/// 侵入數據資料表(目前沒有作用)
class InvasiveComprehensiveData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get bloodGlucoseMode => integer()();
  RealColumn get bloodGlucose => real()();
  IntColumn get uricAcidMode => integer()();
  IntColumn get uricAcid => integer()();
  IntColumn get bloodKetoneMode => integer()();
  RealColumn get bloodKetone => real()();
  IntColumn get bloodFatMode => integer()();
  RealColumn get totalCholesterol => real()();
  RealColumn get hdlCholesterol => real()();
  RealColumn get ldlCholesterol => real()();
  RealColumn get triglycerides => real()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))(); // ✅ 預設未同步

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}
