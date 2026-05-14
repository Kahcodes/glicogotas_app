import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/app_routes.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/myths_truths/data/myth_truth_topics.dart';
import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_topic.dart';
import 'package:glicogotas_app/features/myths_truths/presentation/myths_truths_reader_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MythsTruthsPage extends StatelessWidget {
  const MythsTruthsPage({super.key});

  static const _purple = Color(0xFF9C6ADE);
  static const _titlePurple = Color(0xFF680DDF);

  void _openTopic(BuildContext context, MythTruthTopic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '${AppRoutes.mythsTruths}/${topic.id}'),
        builder: (_) => MythsTruthsReaderPage(topic: topic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.home_rounded, color: _purple),
                    onPressed: () => AppNavigator.goHome(context),
                  ),
                  Expanded(
                    child: Text(
                      'Mitos ou Verdades',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.chewy(
                        color: _titlePurple,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.settings, color: _purple),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ConfigDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                itemCount: mythTruthTopics.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemBuilder: (context, index) {
                  final topic = mythTruthTopics[index];
                  return _MythTopicCard(
                    topic: topic,
                    onTap: () => _openTopic(context, topic),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MythTopicCard extends StatelessWidget {
  const _MythTopicCard({required this.topic, required this.onTap});

  final MythTruthTopic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: topic.title,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 6,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: SvgPicture.asset(
            topic.cardAsset,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
