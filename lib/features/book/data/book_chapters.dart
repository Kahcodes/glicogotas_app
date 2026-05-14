import 'package:glicogotas_app/features/book/data/diabetes_chapter.dart';
import 'package:glicogotas_app/features/book/domain/book_chapter.dart';
import 'package:glicogotas_app/features/book/domain/book_page_content.dart';

final bookChapters = [
  diabetesChapter,
  pancreasChapter,
  insulinChapter,
  hypoglycemiaChapter,
  hyperglycemiaChapter,
  typeTwoDiabetesChapter,
];

final pancreasChapter = BookChapter(
  id: 'pancreas',
  title: 'Pâncreas',
  coverAsset: 'assets/images/pancreas-capa.png',
  pages: _chapterPages(
    backgroundAsset: 'assets/images/fundopaglivro.svg',
    audioAssets: [
      'audio/panc-pagina1.mp3',
      'audio/panc-pagina2.mp3',
      'audio/panc-pagina3.mp3',
      'audio/panc-pagina4.mp3',
      'audio/panc-pagina5.mp3',
      'audio/panc-pagina6.mp3',
      'audio/panc-pagina7.mp3',
    ],
    characterAssets: [
      'assets/images/lita.svg',
      'assets/images/lita.svg',
      'assets/images/lita-pancreas.svg',
      'assets/images/lita-pancreas.svg',
      'assets/images/pancreas.svg',
      'assets/images/pancreas.svg',
      'assets/images/pancreas.svg',
    ],
    balloonAssets: [
      'assets/images/balão-duplo.svg',
      'assets/images/balão-page2.svg',
      'assets/images/balão-page3.svg',
      'assets/images/balão-page4.svg',
      'assets/images/balão-page5.svg',
      'assets/images/balão-page6.svg',
      'assets/images/balão-page7.svg',
    ],
  ),
);

final insulinChapter = BookChapter(
  id: 'insulina',
  title: 'Insulina',
  coverAsset: 'assets/images/insulina-capa.png',
  pages: _chapterPages(
    backgroundAsset: 'assets/images/fundoinsulinas.svg',
    audioAssets: [
      'audio/pagina1insu.mp3',
      'audio/pagina2insu.mp3',
      'audio/pagina3insu.mp3',
      'audio/pagina4insu.mp3',
      'audio/pagina5insu.mp3',
      'audio/pagina6insu.mp3',
      'audio/pagina7insu.mp3',
      'audio/pagina8insu.mp3',
      'audio/pagina9insu.mp3',
    ],
    characterAssets: [
      'assets/images/lita-insulins.svg',
      'assets/images/insulins2.svg',
      'assets/images/lita-pensa.svg',
      'assets/images/insulins3.svg',
      'assets/images/rapido.svg',
      'assets/images/lita-uau.svg',
      'assets/images/insulinas.svg',
      'assets/images/insulins.svg',
      'assets/images/lita-coracao.svg',
    ],
    balloonAssets: [
      'assets/images/balao-ins-page1.svg',
      'assets/images/balao-ins-page2.svg',
      'assets/images/balao-ins-page3.svg',
      'assets/images/balao-ins-page4.svg',
      'assets/images/balao-ins-page5.svg',
      'assets/images/balao-ins-page6.svg',
      'assets/images/balao-ins-page7.svg',
      'assets/images/balao-ins-page8.svg',
      'assets/images/balao-ins-page9.svg',
    ],
  ),
);

final hypoglycemiaChapter = BookChapter(
  id: 'hipoglicemia',
  title: 'Hipoglicemia',
  coverAsset: 'assets/images/card-hipo.png',
  pages: _chapterPages(
    backgroundAsset: 'assets/images/fundo-hipo.svg',
    audioAssets: [
      'audio/audios-hipoglicemia/tela1-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela2-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela3-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela4-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela5-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela6-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela7-hipoglicemia.mp3',
      'audio/audios-hipoglicemia/tela8-hipoglicemia.mp3',
    ],
    characterAssets: [
      'assets/images/betinho-person.svg',
      'assets/images/error.svg',
      'assets/images/Lita-atencao.svg',
      'assets/images/Lita-uau2.svg',
      'assets/images/Betinho-ensinando.svg',
      'assets/images/Betinho-pumps.svg',
      'assets/images/Lita-geladeira.svg',
      'assets/images/barraca-hipo.svg',
    ],
    balloonAssets: [
      'assets/images/balao-hipo1.svg',
      'assets/images/balao-hipo2.svg',
      'assets/images/balao-hipo3.svg',
      'assets/images/balao-hipo4.svg',
      'assets/images/balao-hipo5.svg',
      'assets/images/balao-hipo6.svg',
      'assets/images/balao-hipo7.svg',
      'assets/images/balao-hipo8.svg',
    ],
  ),
);

final hyperglycemiaChapter = BookChapter(
  id: 'hiperglicemia',
  title: 'Hiperglicemia',
  coverAsset: 'assets/images/card-hiper.png',
  pages: _chapterPages(
    backgroundAsset: 'assets/images/fundo-hiper.svg',
    audioAssets: [
      'audio/audios-hiperglicemia/tela1-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela2-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela3-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela4-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela5-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela6-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela7-hiperglicemia.mp3',
      'audio/audios-hiperglicemia/tela8-hiperglicemia.mp3',
    ],
    characterAssets: [
      'assets/images/Pumps-anunciando.svg',
      'assets/images/Pumps-anunciando2.svg',
      'assets/images/Lita-xixi.svg',
      'assets/images/pumps-ens.svg',
      'assets/images/Lita-irritada.svg',
      'assets/images/Medica-lita.svg',
      'assets/images/Saudavel.svg',
      'assets/images/Lita-espada.svg',
    ],
    balloonAssets: [
      'assets/images/balao-hiper1.svg',
      'assets/images/balao-hiper2.svg',
      'assets/images/balao-hiper3.svg',
      'assets/images/balao-hiper4.svg',
      'assets/images/balao-hiper5.svg',
      'assets/images/balao-hiper6.svg',
      'assets/images/balao-hiper7.svg',
      'assets/images/balao-hiper8.svg',
    ],
  ),
);

final typeTwoDiabetesChapter = BookChapter(
  id: 'diabetes_tipo_2',
  title: 'Diabetes Tipo 2',
  coverAsset: 'assets/images/card-vovo.png',
  pages: _chapterPages(
    backgroundAsset: 'assets/images/fundo-vovo.svg',
    audioAssets: [
      'audio/audios-diabtp2/diabtp2-1.mp3',
      'audio/audios-diabtp2/diabtp2-2.mp3',
      'audio/audios-diabtp2/diabtp2-3.mp3',
      'audio/audios-diabtp2/diabtp2-4.mp3',
      'audio/audios-diabtp2/diabtp2-5.mp3',
      'audio/audios-diabtp2/diabtp2-6.mp3',
      'audio/audios-diabtp2/diabtp2-7.mp3',
      'audio/audios-diabtp2/diabtp2-8.mp3',
      'audio/audios-diabtp2/diabtp2-9.mp3',
      'audio/audios-diabtp2/diabtp2-10.mp3',
      'audio/audios-diabtp2/diabtp2-11.mp3',
      'audio/audios-diabtp2/diabtp2-12.mp3',
    ],
    characterAssets: [
      'assets/images/lita-pensa.svg',
      'assets/images/fe-acena.svg',
      'assets/images/lita-raiox.svg',
      'assets/images/fe-vovo.svg',
      'assets/images/rei-pancreas.svg',
      'assets/images/fe-acena.svg',
      'assets/images/medica-vovo.svg',
      'assets/images/fe-acena2.svg',
      'assets/images/fe-insulin.svg',
      'assets/images/fe-forte.svg',
      'assets/images/Lita-uau2.svg',
      'assets/images/fe-acena2.svg',
    ],
    balloonAssets: [
      'assets/images/balao-vovo1.svg',
      'assets/images/balao-vovo2.svg',
      'assets/images/balao-vovo3.svg',
      'assets/images/balao-vovo4.svg',
      'assets/images/balao-vovo5.svg',
      'assets/images/balao-vovo6.svg',
      'assets/images/balao-vovo7.svg',
      'assets/images/balao-vovo8.svg',
      'assets/images/balao-vovo9.svg',
      'assets/images/balao-vovo10.svg',
      'assets/images/balao-vovo11.svg',
      'assets/images/balao-vovo12.svg',
    ],
  ),
);

List<BookPageContent> _chapterPages({
  required String backgroundAsset,
  required List<String> audioAssets,
  required List<String> characterAssets,
  required List<String> balloonAssets,
}) {
  return List.generate(audioAssets.length, (index) {
    return BookPageContent(
      audioAsset: audioAssets[index],
      backgroundAsset: backgroundAsset,
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: characterAssets[index],
          topFactor: 0.34,
          leftFactor: 0.03,
          rightFactor: 0.03,
          widthFactor: 0.48,
          heightFactor: 0.48,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: balloonAssets[index],
          topFactor: 0.14,
          leftFactor: 0.02,
          rightFactor: 0.08,
          widthFactor: 0.72,
        ),
      ],
    );
  });
}
