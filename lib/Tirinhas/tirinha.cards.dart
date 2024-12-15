import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/home.dart'; // Importa a tela inicial
import 'package:glicogotas_app/configuracoes.dart'; // Importa o diálogo de configurações
import 'package:glicogotas_app/Tirinhas/tirinha_docura.dart'; // Importa a página Tirinha
import 'package:glicogotas_app/Tirinhas/tirinha_insulina.dart';

class TirinhaCardsPage extends StatelessWidget {
  const TirinhaCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfff3f6), // Fundo da página
      body: Stack(
        children: [
          // Título "Selecione um Capítulo" com ícones
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ícone "Home"
                IconButton(
                  icon: const Icon(
                    Icons.home_rounded,
                    color: Color(0xFFF4719C),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaHome()),
                    );
                  },
                ),
                Text(
                  'Selecione uma tirinha', // Título da página
                  style: GoogleFonts.chewy(
                    color: const Color(0xFF37ABDC),
                    fontSize: 24,
                  ),
                ),
                // Ícone "Configurações"
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Color(0xFFF4719C), // Cor do ícone ajustada
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfigDialog(); // Chama o diálogo de configurações
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // Grid de cards com espaçamento ajustado
          Padding(
            padding: const EdgeInsets.only(
                top: 120.0), // Ajusta os cards mais para baixo
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Card 1
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Tirinha()),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/tirinha-docura-capa.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
                // Card 2
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TirinhaInsulina()),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/tirinha-insu-capa.png', // Exemplo de imagem
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
                // Card 3

                // Card 4 (Exemplo adicional)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
