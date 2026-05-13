import 'book_page_content.dart';

class BookChapter {
  const BookChapter({
    required this.id,
    required this.title,
    required this.coverAsset,
    required this.pages,
  });

  final String id;
  final String title;
  final String coverAsset;
  final List<BookPageContent> pages;
}
