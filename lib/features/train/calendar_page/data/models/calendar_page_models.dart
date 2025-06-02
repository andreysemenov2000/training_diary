import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_page_models.freezed.dart';

part 'calendar_page_models.g.dart';

@freezed
abstract class TrainingDBResponseModel with _$TrainingDBResponseModel {
  const factory TrainingDBResponseModel({
    required int id,
    required String name,
    required String date,
  }) = _TrainingDBResponseModel;

  factory TrainingDBResponseModel.fromJson(Map<String, Object?> json) =>
      _$TrainingDBResponseModelFromJson(json);
}

@freezed
abstract class TrainingDBQueryModel with _$TrainingDBQueryModel {
  const factory TrainingDBQueryModel({
    required String name,
    required String date,
  }) = _TrainingDBQueryModel;

  factory TrainingDBQueryModel.fromJson(Map<String, Object?> json) =>
      _$TrainingDBQueryModelFromJson(json);
}
