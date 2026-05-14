class Comic {
  const Comic({
    required this.id,
    required this.title,
    required this.coverAsset,
    required this.pages,
  });

  final String id;
  final String title;
  final String coverAsset;
  final List<String> pages;
}
