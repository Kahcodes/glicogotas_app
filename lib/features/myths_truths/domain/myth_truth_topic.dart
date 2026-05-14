import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_page_content.dart';

class MythTruthTopic {
  const MythTruthTopic({
    required this.id,
    required this.title,
    required this.cardAsset,
    required this.pages,
  });

  final String id;
  final String title;
  final String cardAsset;
  final List<MythTruthPageContent> pages;
}
