class EegModel {
  final int? id_eeg;
  final int? seizure_vote;
  final int? ipd_vote;
  final int? gpd_vote;
  final int? irda_vote;
  final int? grade_vote;
  final int? other_vote;
  EegModel(
    this.seizure_vote,
    this.ipd_vote,
    this.gpd_vote,
    this.irda_vote,
    this.grade_vote,
    this.other_vote,
    this.id_eeg,
  );
}


