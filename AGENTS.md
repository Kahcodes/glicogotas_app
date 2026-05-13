# Repository Guidelines

## Estado Atual Da Arquitetura

Este é um app Flutter refatorado para uma arquitetura escalável baseada em `app/`, `core/` e `features/`. O MVP atual expõe somente `Livro` e `Personagens`, preservando a identidade visual original, assets, fontes, cores e áudio.

`main.dart` deve permanecer mínimo: inicializa o Flutter e chama `GlicogotasApp`. O bootstrap real fica em `lib/app/glicogotas_app.dart`, providers em `lib/app/app_providers.dart`, nomes de rota em `lib/app/app_routes.dart` e `routeObserver` em `lib/app/route_observer.dart`.

## Project Structure & Module Organization

Estrutura principal:

- `lib/app/`: composição do app, providers globais, rotas nomeadas e observador de rotas.
- `lib/core/`: infraestrutura compartilhada sem regra específica de feature.
  - `core/audio/`: `AudioController` e serviço de player.
  - `core/navigation/`: helpers globais como `AppNavigator.goHome`.
  - `core/persistence/`: wrappers de `SharedPreferences` e progresso de leitura.
  - `core/theme/`: cores e assets compartilhados.
  - `core/ui/`: widgets reutilizáveis como `ConfigDialog` e `OutlinedText`.
- `lib/features/`: features novas ou migradas, separadas em `domain/`, `data/` e `presentation/`.
  - `startup`: tela inicial.
  - `home`: Home do MVP com `Livro` e `Personagens`.
  - `settings`: estado e persistência de configurações.
  - `book`: capítulos declarativos e leitor genérico.
  - `characters`: perfis declarativos e tela genérica de personagens.
- `test/`: testes de widget e unitários.

Pastas antigas como `lib/Livro/`, `lib/Personagens/`, `lib/MitosOuVerdades/`, `lib/Tirinhas/` e `lib/Video/` ainda podem existir por compatibilidade ou histórico. Não adicione implementação nova nelas. Para código novo, use `lib/features/...`. Wrappers antigos como `home.dart`, `iniciar.dart`, `configuracoes.dart`, `Livro/cards.dart` e `Personagens/glicogotas.dart` apontam para a arquitetura nova.

Assets ficam em `assets/images/`, `assets/audio/`, `assets/sounds/`, `assets/videos/` e `assets/icon/`; todo asset em runtime deve estar declarado em `pubspec.yaml`.

## Regras De Arquitetura

Preserve separação de responsabilidades:

- `domain/`: modelos puros e estáveis, sem dependência de UI sempre que possível.
- `data/`: catálogos estáticos, mapeamento de assets, repositórios e fontes de dados.
- `presentation/`: widgets, controllers de tela e composição visual.
- `core/`: somente código compartilhado por mais de uma feature.

Não crie uma tela nova para cada página de livro ou personagem. O padrão novo é declarativo:

- Capítulos usam `BookChapter`, `BookPageContent` e `BookVisualLayer`.
- Personagens usam `CharacterProfile`.
- Home usa `HomeMenuItem`.

Botões de casinha devem voltar para a Home existente sem duplicar rotas usando `AppNavigator.goHome(context)`. Botões de livro dentro do leitor devem continuar voltando para a lista de capítulos com `Navigator.pop(context)`.

Áudio não deve depender diretamente de `BuildContext`. Use `AudioController` e `AudioPlayerService`, integrados ao estado de configurações.

## Como Adicionar Capítulos Do Livro

Adicione novos capítulos em `lib/features/book/data/`, seguindo o padrão de `diabetes_chapter.dart`. Cada capítulo deve declarar:

- `id`
- `title`
- `coverAsset`
- lista de `BookPageContent`

Cada página deve conter o áudio, fundo e camadas visuais:

```dart
const pancreasChapter = BookChapter(
  id: 'pancreas',
  title: 'Pâncreas',
  coverAsset: 'assets/images/pancreas-capa.png',
  pages: [
    BookPageContent(
      audioAsset: 'audio/panc-pagina1.mp3',
      backgroundAsset: 'assets/images/fundopaglivro.svg',
      layers: [
        BookVisualLayer(
          type: BookLayerType.svg,
          asset: 'assets/images/lita.svg',
          topFactor: 0.30,
          heightFactor: 0.60,
        ),
      ],
    ),
  ],
);
```

Depois registre o capítulo na tela/lista de capítulos em `features/book/presentation`. Não recrie uma classe `StatefulWidget` por página.

## Como Adicionar Outras Features

Para reativar ou criar uma feature, use:

```text
lib/features/nome_da_feature/
  domain/
  data/
  presentation/
```

Exemplos esperados:

- `features/myths_truths/`
- `features/comics/`
- `features/video/`
- `features/games/`

Só adicione o card na Home quando a feature estiver usando a nova estrutura. Edite `lib/features/home/presentation/home_page.dart` e registre um novo `HomeMenuItem`.

## Build, Test, And Development Commands

Run these from the repository root:

- `flutter pub get`: install Dart and Flutter dependencies.
- `flutter run`: launch the app on the selected emulator, simulator, browser, or device.
- `flutter analyze`: run the Dart analyzer and `flutter_lints` checks.
- `flutter test`: run widget and unit tests under `test/`.
- `flutter build apk`: create an Android release APK.
- `dart format lib test`: format Dart files before submitting changes.

Para rodar no emulador Android configurado nesta máquina:

```powershell
flutter emulators --launch Medium_Phone_API_36.0
flutter run -d emulator-5554
```

## Coding Style & Naming Conventions

Use formatação padrão Dart: dois espaços, trailing commas em árvores de widgets multilinha e `dart format` como fonte da verdade. Use `UpperCamelCase` para classes/widgets, `lowerCamelCase` para métodos, variáveis e providers, e `snake_case.dart` para novos arquivos.

Ao adicionar assets, prefira nomes novos em lowercase ASCII sem espaços. Não renomeie assets antigos só por estilo, porque isso pode quebrar referências existentes.

## Testing Guidelines

Use `flutter_test`. Testes devem cobrir comportamento visível, navegação, áudio/configurações e persistência simples. Antes de finalizar mudanças, rode:

- `flutter analyze`
- `flutter test`
- `flutter build apk --debug` para mudanças estruturais ou de navegação

Mantenha testes de regressão para:

- Home do MVP com `Livro` e `Personagens`.
- Botões de casinha não duplicando Home.
- Botão de livro voltando para capítulos.
- Capítulo Diabetes completo como capítulo modelo.
- Todos os personagens atuais registrados em `characterProfiles`.

## Commit & Pull Request Guidelines

Recent commits usam mensagens curtas em português, como `atualizando botoes` e `arrumando tirinhas para svg`. Mantenha o assunto conciso e orientado à ação; mencione a feature afetada quando útil.

PRs devem incluir resumo, testes rodados e screenshots ou gravações para mudanças visuais. Destaque alterações em assets, `pubspec.yaml`, navegação, persistência, áudio ou plataforma.

## Security & Configuration Tips

Não commite novas chaves, certificados, tokens ou caminhos locais. Trate `.p12` como sensível. Configuração de assinatura/plataforma deve ficar fora de mudanças de feature, salvo quando o PR for de release/setup.
