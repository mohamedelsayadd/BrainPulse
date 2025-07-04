import 'package:brain_pulse/features/home/data/repo/predict_file_repo_imple.dart';
import 'package:brain_pulse/features/home/presentation/controller/cubit/prediction_file_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictionFileCubit extends Cubit<PredictionFileState> {
  final PredictFileRepoImple predictFileRepoImple;

  PredictionFileCubit({required this.predictFileRepoImple})
      : super(InitialPredictionFileState());

  Future<void> uploadEegFile(String filePath) async {
    emit(LoadingPredictionFileState());

    final result = await predictFileRepoImple.uploadEegFile(filePath);

    result.fold(
      (failure) {
        print('❌ Failure: ${failure.errorMessage}');
        emit(ErrorPredictionFileState(errormsg: failure.errorMessage));
      },
      (predictionModel) {
        print('✅ Prediction Loaded: ${predictionModel.parsedPrediction}');

        emit(LoadedPredictionFileState(
            prediction: predictionModel.parsedPrediction));
      },
    );
  }

  void reset() {
    emit(InitialPredictionFileState());
  }
}

// class PredictionImageCubit extends Cubit<PredictionImageState> {
//   final PredictImageRepoImple predictImageRepoImple;

//   PredictionImageCubit({required this.predictImageRepoImple})
//       : super(InitialPredictionImageState());

//   Future<void> uploadImage(File image) async {
//     emit(LoadingPredictionImageState());
//     final result = await predictImageRepoImple.postimage(image: image);

//     result.fold(
//       (error) => emit(ErrorPredictionImageState(errormsg: error)),
//       (predictionModel) => emit(
//         LoadedPredictionImageState(
//           image: image,
//           gpd: predictionModel.gpd,
//           grda: predictionModel.grda,
//           lpd: predictionModel.lpd,
//           lrda: predictionModel.lrda,
//           seizure: predictionModel.seizure,
//           other: predictionModel.other,
//         ),
//       ),
//     );
//   }
// }
