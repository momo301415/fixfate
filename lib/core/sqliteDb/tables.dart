import 'package:drift/drift.dart';

class StepData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get endTimeStamp => integer()();
  IntColumn get step => integer()();
  IntColumn get distance => integer()();
  IntColumn get calories => integer()();

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

class SleepData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get endTimeStamp => integer()();
  IntColumn get deepSleepSeconds => integer()();
  IntColumn get lightSleepSeconds => integer()();
  IntColumn get remSleepSeconds => integer()();
  BoolColumn get isNewSleepProtocol =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

class SleepDetailData extends Table {
  TextColumn get userId => text()(); // 關聯用
  IntColumn get sleepStartTimeStamp =>
      integer()(); // 關聯到 SleepData 的 startTimeStamp
  IntColumn get startTimeStamp => integer()();
  IntColumn get duration => integer()();
  IntColumn get sleepType => integer()();

  @override
  Set<Column> get primaryKey => {userId, sleepStartTimeStamp, startTimeStamp};
}

class HeartRateData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get heartRate => integer()();

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

class BloodPressureData extends Table {
  TextColumn get userId => text()();
  IntColumn get startTimeStamp => integer()();
  IntColumn get systolicBloodPressure => integer()();
  IntColumn get diastolicBloodPressure => integer()();
  IntColumn get mode => integer()();

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

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

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}

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

  @override
  Set<Column> get primaryKey => {userId, startTimeStamp};
}
