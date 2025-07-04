class ImagePredictionModel {
  final double gpd;
  final double grda;
  final double lpd;
  final double lrda;
  final double seizure;
  final double other;

  ImagePredictionModel({
    required this.gpd,
    required this.grda,
    required this.lpd,
    required this.lrda,
    required this.seizure,
    required this.other,
  });

  factory ImagePredictionModel.fromJson(Map<String, dynamic> json) {
    return ImagePredictionModel(
      gpd: (json['GPD'] as num?)?.toDouble() ?? 0.0,
      grda: (json['GRDA'] as num?)?.toDouble() ?? 0.0,
      lpd: (json['LPD'] as num?)?.toDouble() ?? 0.0,
      lrda: (json['LRDA'] as num?)?.toDouble() ?? 0.0,
      seizure: (json['Seizure'] as num?)?.toDouble() ?? 0.0,
      other: (json['Other'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

