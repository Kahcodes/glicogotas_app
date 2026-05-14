import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glicogotas_app/app/app_routes.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/persistence/preferences_store.dart';
import 'package:glicogotas_app/features/book/data/book_chapters.dart';
import 'package:glicogotas_app/features/book/data/diabetes_chapter.dart';
import 'package:glicogotas_app/features/characters/data/character_profiles.dart';
import 'package:glicogotas_app/features/comics/data/comics.dart';
import 'package:glicogotas_app/features/myths_truths/data/myth_truth_topics.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glicogotas_app/main.dart';

void main() {
  testWidgets('exibe a tela inicial do app', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const GlicogotasApp());
    await tester.pumpAndSettle();

    expect(find.text('Desvendando o Diabetes'), findsOneWidget);
    expect(find.text('INICIAR'), findsOneWidget);
  });

  test('carrega e persiste configuracoes de audio', () async {
    SharedPreferences.setMockInitialValues({
      'musicOn': true,
      'soundOn': true,
      'volume': 0.7,
    });

    final repository = SettingsRepository(PreferencesStore());
    await repository.load();

    await repository.switchMusicOn();
    await repository.setVolume(0.4);

    expect(repository.musicOn, isFalse);
    expect(repository.volume, 0.4);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('musicOn'), isFalse);
    expect(prefs.getDouble('volume'), 0.4);
  });

  test('mvp mantem capitulo diabetes completo como livro modelo', () {
    expect(diabetesChapter.title, 'Diabetes');
    expect(diabetesChapter.pages, hasLength(7));
    expect(diabetesChapter.pages.first.isCover, isTrue);
  });

  test('livro mantem todos os capitulos declarativos', () {
    expect(bookChapters.map((chapter) => chapter.id), [
      'diabetes',
      'pancreas',
      'insulina',
      'hipoglicemia',
      'hiperglicemia',
      'diabetes_tipo_2',
    ]);
  });

  test('mvp mantem todos os personagens atuais', () {
    expect(characterProfiles.map((profile) => profile.name), [
      'Lita',
      'Rei da Hiper',
      'Bobo da Hipo',
      'Fê',
      'Insulins',
      'Pumps',
      'Betinho',
      'Canetto',
    ]);
  });

  test('feature mitos e verdades mantem temas declarativos atuais', () {
    expect(mythTruthTopics.map((topic) => topic.id), [
      'causas_diabetes',
      'doces',
      'frutas',
      'diet',
      'mel',
      'atividade_fisica',
    ]);
    expect(mythTruthTopics.every((topic) => topic.pages.length == 4), isTrue);
    expect(
        mythTruthTopics.every((topic) => topic.pages.first.isQuestion), isTrue);
  });

  test('feature tirinhas mantem tirinhas declarativas atuais', () {
    expect(comics.map((comic) => comic.id), [
      'docura',
      'insulina',
      'glicoamigos',
      'agua_vai',
      'bateria_fraca',
      'missao',
    ]);
  });

  testWidgets('botao de casinha volta para Home sem duplicar rota', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: ElevatedButton(
                key: const Key('start-button'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: AppRoutes.home),
                      builder: (_) => Scaffold(
                        body: Column(
                          children: [
                            const Text('Home'),
                            ElevatedButton(
                              key: const Key('book-button'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Scaffold(
                                      body: ElevatedButton(
                                        key: const Key('home-button'),
                                        onPressed: () {
                                          AppNavigator.goHome(context);
                                        },
                                        child: const Text('Casa'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Livro'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Start'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('start-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('book-button')));
    await tester.pumpAndSettle();

    expect(find.text('Casa'), findsOneWidget);

    await tester.tap(find.byKey(const Key('home-button')));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Casa'), findsNothing);

    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
  });
}
