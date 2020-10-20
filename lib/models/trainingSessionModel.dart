class TrainingSessionModel {
  String id;
  String title;
  int numberOfTrainingIntervals;
  int trainingIntervalDuration;
  int breakIntervalDuration;

  TrainingSessionModel({
    this.id,
    this.title,
    this.numberOfTrainingIntervals,
    this.trainingIntervalDuration,
    this.breakIntervalDuration,
  });
}
