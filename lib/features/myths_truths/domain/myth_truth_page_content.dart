class MythTruthPageContent {
  const MythTruthPageContent({
    this.question,
    this.correctAnswer,
    required this.title,
    required this.explanation,
  });

  final String? question;
  final bool? correctAnswer;
  final String title;
  final String explanation;

  bool get isQuestion => question != null && correctAnswer != null;
}
