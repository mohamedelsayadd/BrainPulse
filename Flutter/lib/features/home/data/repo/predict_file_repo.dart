import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/home/data/model/file_predict_model.dart';
import 'package:dartz/dartz.dart';

abstract class PredictFileRepo {
  Future<Either<Failure, FilePredictModel>> uploadEegFile(String filePath);
}
