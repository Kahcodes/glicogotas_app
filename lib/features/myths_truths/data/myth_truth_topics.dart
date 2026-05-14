import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_page_content.dart';
import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_topic.dart';

const mythTruthTopics = [
  MythTruthTopic(
    id: 'causas_diabetes',
    title: 'Causas do Diabetes',
    cardAsset: 'assets/images/causa.svg',
    pages: [
      MythTruthPageContent(
        question: 'O DM1 é causado por comer muito açúcar?',
        correctAnswer: false,
        title: 'É MITO!',
        explanation:
            'Muitas pessoas ainda acreditam que o diabetes tipo 1 surge por causa do consumo excessivo de doces, mas isso não é verdade.',
      ),
      MythTruthPageContent(
        title: 'O que realmente acontece?',
        explanation:
            'O diabetes tipo 1 é uma condição autoimune: o sistema imunológico ataca as células do pâncreas que produzem insulina.',
      ),
      MythTruthPageContent(
        title: 'Nada de culpar o chocolate!',
        explanation:
            'O diabetes tipo 1 não pode ser prevenido e não tem relação com hábitos alimentares.',
      ),
      MythTruthPageContent(
        title: 'E o que fazer?',
        explanation:
            'Com monitoramento, contagem de carboidratos e uso de insulina, é possível viver com saúde e energia!',
      ),
    ],
  ),
  MythTruthTopic(
    id: 'doces',
    title: 'Doces Proibidos',
    cardAsset: 'assets/images/doces.svg',
    pages: [
      MythTruthPageContent(
        question: 'Doces são completamente proibidos?',
        correctAnswer: false,
        title: 'É MITO!',
        explanation:
            'Quem tem diabetes tipo 1 pode comer doces, desde que conte os carboidratos e ajuste a insulina.',
      ),
      MythTruthPageContent(
        title: 'O segredo está no equilíbrio',
        explanation:
            'Não é necessário cortar totalmente os doces. O importante é aprender a incluir de forma consciente na rotina.',
      ),
      MythTruthPageContent(
        title: 'Conversa com a equipe médica',
        explanation:
            'O acompanhamento com nutricionista e endocrinologista ajuda a saber quando e como consumir sem prejuízos.',
      ),
      MythTruthPageContent(
        title: 'Você pode, sim!',
        explanation:
            'Com planejamento e orientação, os doces podem fazer parte de uma vida saudável.',
      ),
    ],
  ),
  MythTruthTopic(
    id: 'frutas',
    title: 'Frutas',
    cardAsset: 'assets/images/frutas.svg',
    pages: [
      MythTruthPageContent(
        question: 'Quem tem diabetes pode comer frutas?',
        correctAnswer: true,
        title: 'É VERDADE!',
        explanation:
            'As pessoas com diabetes PODEM comer frutas. Elas são fontes de fibras, vitaminas e minerais importantes para a saúde.',
      ),
      MythTruthPageContent(
        title: 'Mas com moderação',
        explanation:
            'A recomendação é consumir até 4 porções por dia, escolhendo frutas mais fibrosas como maçã, pera e laranja.',
      ),
      MythTruthPageContent(
        title: 'Atenção à frutose',
        explanation:
            'Frutas têm frutose, um tipo de açúcar natural. O excesso pode elevar a glicose no sangue.',
      ),
      MythTruthPageContent(
        title: 'Equilíbrio é a chave',
        explanation:
            'Inclua frutas na alimentação de forma consciente e converse com o nutricionista para ajustar ao seu plano alimentar.',
      ),
    ],
  ),
  MythTruthTopic(
    id: 'diet',
    title: 'Produtos Diet',
    cardAsset: 'assets/images/diet.svg',
    pages: [
      MythTruthPageContent(
        question: 'Produtos diet estão liberados para comer à vontade?',
        correctAnswer: false,
        title: 'É MITO!',
        explanation:
            'Apesar de não terem açúcar, os produtos diet podem ter mais gordura para ficarem saborosos. Isso aumenta as calorias.',
      ),
      MythTruthPageContent(
        title: 'Cuidado com o exagero',
        explanation:
            'Consumir em excesso pode prejudicar a glicose e a saúde do coração.',
      ),
      MythTruthPageContent(
        title: 'Consumo consciente',
        explanation:
            'Os produtos diet podem ser incluídos na rotina, mas sempre em moderação.',
      ),
      MythTruthPageContent(
        title: 'Converse com a equipe de saúde',
        explanation:
            'Um nutricionista pode orientar sobre a quantidade adequada para cada pessoa.',
      ),
    ],
  ),
  MythTruthTopic(
    id: 'mel',
    title: 'Mel',
    cardAsset: 'assets/images/mel.svg',
    pages: [
      MythTruthPageContent(
        question: 'Por ser natural, o mel está liberado para comer à vontade?',
        correctAnswer: false,
        title: 'É MITO!',
        explanation:
            'Mesmo sendo natural, o mel tem muito açúcar e pode aumentar a glicose rapidamente.',
      ),
      MythTruthPageContent(
        title: 'Atenção ao consumo',
        explanation:
            'O mel deve ser usado com moderação, assim como qualquer outro alimento rico em açúcar.',
      ),
      MythTruthPageContent(
        title: 'Natural não é sinônimo de liberado',
        explanation:
            'Nem todo alimento natural é indicado em grandes quantidades para quem tem diabetes.',
      ),
      MythTruthPageContent(
        title: 'Converse sempre com a equipe de saúde',
        explanation:
            'Nutricionista e médico podem orientar a forma mais segura de incluir o mel na alimentação.',
      ),
    ],
  ),
  MythTruthTopic(
    id: 'atividade_fisica',
    title: 'Atividade Física',
    cardAsset: 'assets/images/ativ_fisica.svg',
    pages: [
      MythTruthPageContent(
        question: 'Quem tem diabetes pode praticar atividades físicas?',
        correctAnswer: true,
        title: 'É VERDADE!',
        explanation:
            'O exercício físico é muito importante para quem tem diabetes. Ele ajuda a controlar a glicose, melhora a circulação e fortalece o coração.',
      ),
      MythTruthPageContent(
        title: 'Benefícios para o corpo',
        explanation:
            'A prática regular de atividade física aumenta a sensibilidade à insulina e melhora o bem-estar.',
      ),
      MythTruthPageContent(
        title: 'Escolha a atividade que você gosta',
        explanation:
            'Caminhar, dançar, pedalar... o importante é se manter em movimento de forma prazerosa.',
      ),
      MythTruthPageContent(
        title: 'Acompanhamento é essencial',
        explanation:
            'Converse com seu médico antes de iniciar para adaptar os cuidados e garantir segurança.',
      ),
    ],
  ),
];
