import 'package:flutter/material.dart';
import 'package:glicogotas_app/features/book/domain/book_chapter.dart';
import 'package:glicogotas_app/features/book/domain/book_page_content.dart';

const diabetesChapter = BookChapter(
  id: 'diabetes',
  title: 'Diabetes',
  coverAsset: 'assets/images/diabetes-capa.png',
  pages: [
    BookPageContent(
      isCover: true,
      audioAsset: 'audio/titulo.mp3',
      backgroundAsset: '',
      layers: [
        BookVisualLayer(
          type: BookLayerType.image,
          asset: 'assets/images/talita_capa.png',
          bottomFactor: 0,
          leftFactor: 0,
          heightFactor: 0.42,
          fit: BoxFit.cover,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag1.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/doutora-e-lita.svg',
          topFactor: 0.30,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.5,
          heightFactor: 0.5,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page1.svg',
          topFactor: 0.15,
          leftFactor: 0.01,
          rightFactor: 0.02,
          widthFactor: 0.7,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag2.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/lita-respondendo.svg',
          topFactor: 0.35,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.5,
          heightFactor: 0.5,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page2.svg',
          topFactor: 0.14,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.7,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag3.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/lita-respondendo.svg',
          topFactor: 0.35,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.5,
          heightFactor: 0.5,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page3.svg',
          topFactor: 0.15,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.7,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag4.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/lita-educando.svg',
          topFactor: 0.35,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.5,
          heightFactor: 0.5,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page4.svg',
          topFactor: 0.14,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.6,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag5.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/celulas.svg',
          topFactor: 0.30,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.5,
          heightFactor: 0.5,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page5.svg',
          topFactor: 0.15,
          leftFactor: 0.02,
          rightFactor: 0.15,
          widthFactor: 0.7,
        ),
      ],
    ),
    BookPageContent(
      audioAsset: 'audio/diabetespag6.mp3',
      backgroundAsset: 'assets/images/fundodiabetes.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/insulins.svg',
          topFactor: 0.35,
          leftFactor: 0.02,
          rightFactor: 0.02,
          widthFactor: 0.4,
          heightFactor: 0.4,
        ),
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/balao-dm1-page6.svg',
          topFactor: 0.18,
          leftFactor: 0.02,
          rightFactor: 0.15,
          widthFactor: 0.7,
        ),
      ],
    ),
  ],
);
