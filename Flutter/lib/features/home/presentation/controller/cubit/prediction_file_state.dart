abstract class PredictionFileState {}

class InitialPredictionFileState extends PredictionFileState {}

class LoadingPredictionFileState extends PredictionFileState {}

class LoadedPredictionFileState extends PredictionFileState {
  final Map<String, dynamic> prediction;

  LoadedPredictionFileState({required this.prediction});
}

class ErrorPredictionFileState extends PredictionFileState {
  final String errormsg;

  ErrorPredictionFileState({required this.errormsg});
}


// abstract class PredictionImageState {}

// class InitialPredictionImageState extends PredictionImageState {}

// class LoadingPredictionImageState extends PredictionImageState {}

// class LoadedPredictionImageState extends PredictionImageState {
//   final File image;
//   final double gpd;
//   final double grda;
//   final double lpd;
//   final double lrda;
//   final double seizure;
//   final double other;
//   LoadedPredictionImageState({
//     required this.image,
//     required this.gpd,
//     required this.grda,
//     required this.lpd,
//     required this.lrda,
//     required this.seizure,
//     required this.other,
//   });
// }

// class ErrorPredictionImageState extends PredictionImageState {
//   final String errormsg;
//   ErrorPredictionImageState({required this.errormsg});
// }

