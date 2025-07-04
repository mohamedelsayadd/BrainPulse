class FilePredictModel {
  final String rawPrediction;
  final Map<String, double> parsedPrediction;

  FilePredictModel({
    required this.rawPrediction,
    required this.parsedPrediction,
  });

  factory FilePredictModel.fromJson(Map<String, dynamic> json) {
    final raw = json['prediction'] ?? 'Unknown';
    final parsed = _parsePredictionString(raw);

    return FilePredictModel(
      rawPrediction: raw,
      parsedPrediction: parsed,
    );
  }

  /// Helper function to convert string like:
  /// "GPD: 0.02% GRDA: 0.87%" -> Map<String, double>
  static Map<String, double> _parsePredictionString(String prediction) {
    final Map<String, double> result = {};
    final regex = RegExp(r'(\w+): ([\d.]+)%');

    for (final match in regex.allMatches(prediction)) {
      final label = match.group(1);
      final value = match.group(2);

      if (label != null && value != null) {
        result[label] = double.tryParse(value) ?? 0.0;
      }
    }

    return result;
  }
}
