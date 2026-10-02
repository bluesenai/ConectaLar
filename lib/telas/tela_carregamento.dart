import 'package:flutter/material.dart';

class TelaCarregamento extends StatefulWidget {
  const TelaCarregamento({super.key});

  @override
  State<TelaCarregamento> createState() => _TelaCarregamentoState();
}

class _TelaCarregamentoState extends State<TelaCarregamento>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final largura = size.width;
    final altura = size.height;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // =====================================================
            // FUNDO
            // =====================================================
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF991D19),
            ),

            // =====================================================
            // CÍRCULO SUPERIOR ESQUERDO
            // =====================================================
            Positioned(
              top: -altura * 0.12,
              left: -largura * 0.30,
              child: Container(
                width: largura * 0.90,
                height: largura * 0.90,
                decoration: const BoxDecoration(
                  color: Color(0xFFD22720),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // =====================================================
            // FORMA CENTRAL/DIREITA
            // =====================================================
            Positioned(
              top: -altura * 0.03,
              right: -largura * 0.52,
              child: Container(
                width: largura * 1.15,
                height: altura * 0.60,
                decoration: const BoxDecoration(
                  color: Color(0xFFB1211D),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // =====================================================
            // CÍRCULO INFERIOR ESQUERDO
            // =====================================================
            Positioned(
              bottom: -altura * 0.18,
              left: -largura * 0.35,
              child: Container(
                width: largura * 0.95,
                height: largura * 0.95,
                decoration: const BoxDecoration(
                  color: Color(0xFFD22720),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // =====================================================
            // CÍRCULO INFERIOR DIREITO
            // =====================================================
            Positioned(
              bottom: -altura * 0.08,
              right: -largura * 0.35,
              child: Container(
                width: largura * 0.90,
                height: largura * 0.90,
                decoration: const BoxDecoration(
                  color: Color(0xFFEE2E27),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // =====================================================
            // CONTEÚDO CENTRAL
            // =====================================================
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO
                    Image.asset(
                      'assets/images/icone.png',
                      width: largura * 0.25,
                      height: largura * 0.25,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: altura * 0.025),

                    // =================================================
                    // TRÊS PONTOS
                    // =================================================
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final valor = _controller.value * 3;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            final distancia = (valor - index).abs();

                            final escala =
                                1.0 - (distancia.clamp(0.0, 1.0) * 0.35);

                            return Transform.scale(
                              scale: escala,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: largura * 0.018,
                                ),
                                width: largura * 0.023,
                                height: largura * 0.023,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
