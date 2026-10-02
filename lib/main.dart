import 'package:flutter/material.dart';

void main() {
  runApp(const VizinhancaSolidaria());
}

class VizinhancaSolidaria extends StatelessWidget {
  const VizinhancaSolidaria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vizinhança Solidária',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),

      home: const TelaChat(),
    );
  }
}

// ============================================================
// TELA DE CHAT
// ============================================================

class TelaChat extends StatefulWidget {
  const TelaChat({super.key});

  @override
  State<TelaChat> createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {
  final TextEditingController mensagemController =
      TextEditingController();

  // Cores utilizadas no aplicativo
  static const Color vermelho = Color(0xFFF5322C);
  static const Color vermelhoEscuro = Color(0xFFB7191D);
  static const Color fundo = Color(0xFF5C5052);
  static const Color fundoCampo = Color(0xFF675B5D);
  static const Color branco = Colors.white;

  // ----------------------------------------------------------
  // MORADORES
  // ----------------------------------------------------------

  final List<Map<String, String>> moradores = [
    {
      'nome': 'Ana',
      'inicial': 'A',
    },
    {
      'nome': 'Carlos',
      'inicial': 'C',
    },
    {
      'nome': 'Maria',
      'inicial': 'M',
    },
  ];

  // ----------------------------------------------------------
  // MENSAGENS
  // ----------------------------------------------------------

  final List<Map<String, dynamic>> mensagens = [
    {
      'nome': 'Ana',
      'mensagem': 'Bom dia, pessoal! Tudo bem?',
      'minha': false,
    },
    {
      'nome': 'Carlos',
      'mensagem': 'Bom dia! Tudo certo por aqui.',
      'minha': false,
    },
    {
      'nome': 'Você',
      'mensagem': 'Bom dia, vizinhos! 😊',
      'minha': true,
    },
  ];

  // ----------------------------------------------------------
  // ENVIAR MENSAGEM
  // ----------------------------------------------------------

  void enviarMensagem() {
    final texto = mensagemController.text.trim();

    if (texto.isEmpty) {
      return;
    }

    setState(() {
      mensagens.add({
        'nome': 'Você',
        'mensagem': texto,
        'minha': true,
      });
    });

    mensagemController.clear();
  }

  // ----------------------------------------------------------
  // PERFIL DO MORADOR
  // ----------------------------------------------------------

  void abrirPerfil(String nome) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPerfilMorador(nome: nome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,

      // ======================================================
      // PARTE SUPERIOR
      // ======================================================

      body: SafeArea(
        child: Column(
          children: [

            // ------------------------------------------------
            // TOPO
            // ------------------------------------------------

            Container(
              height: 65,
              color: vermelho,

              child: Row(
                children: [

                  const SizedBox(width: 20),

                  // Bolinhas dos moradores
                  Expanded(
                    child: Row(
                      children: moradores.map((morador) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),

                          child: GestureDetector(
                            onTap: () {
                              abrirPerfil(morador['nome']!);
                            },

                            child: CircleAvatar(
                              radius: 18,

                              backgroundColor:
                                  Colors.white,

                              child: Text(
                                morador['inicial']!,

                                style: const TextStyle(
                                  color: vermelhoEscuro,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Seta voltar
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 10),
                ],
              ),
            ),

            // =================================================
            // ÁREA DAS MENSAGENS
            // =================================================

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  20,
                  18,
                  20,
                ),

                itemCount: mensagens.length,

                itemBuilder: (context, index) {
                  final mensagem = mensagens[index];

                  final bool minhaMensagem =
                      mensagem['minha'];

                  return Align(
                    alignment: minhaMensagem
                        ? Alignment.centerRight
                        : Alignment.centerLeft,

                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width *
                                0.75,
                      ),

                      margin: const EdgeInsets.only(
                        bottom: 14,
                      ),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),

                      decoration: BoxDecoration(
                        color: minhaMensagem
                            ? vermelhoEscuro
                            : fundoCampo,

                        borderRadius:
                            BorderRadius.circular(18),

                        border: Border.all(
                          color: Colors.white
                              .withOpacity(0.08),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          if (!minhaMensagem)
                            Text(
                              mensagem['nome'],

                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),

                          if (!minhaMensagem)
                            const SizedBox(height: 4),

                          Text(
                            mensagem['mensagem'],

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // =================================================
            // CAMPO DE MENSAGEM
            // =================================================

            Container(
              padding: const EdgeInsets.fromLTRB(
                14,
                10,
                14,
                14,
              ),

              color: fundo,

              child: Row(
                children: [

                  // Campo de texto
                  Expanded(
                    child: TextField(
                      controller: mensagemController,

                      style: const TextStyle(
                        color: Colors.white,
                      ),

                      cursorColor: Colors.white,

                      textInputAction:
                          TextInputAction.send,

                      onSubmitted: (value) {
                        enviarMensagem();
                      },

                      decoration: InputDecoration(
                        hintText:
                            'Digite uma mensagem...',

                        hintStyle: TextStyle(
                          color: Colors.white
                              .withOpacity(0.55),
                        ),

                        filled: true,

                        fillColor: fundoCampo,

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(30),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Botão enviar
                  Container(
                    width: 52,
                    height: 52,

                    decoration: const BoxDecoration(
                      color: vermelhoEscuro,
                      shape: BoxShape.circle,
                    ),

                    child: IconButton(
                      onPressed: enviarMensagem,

                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mensagemController.dispose();
    super.dispose();
  }
}

// ============================================================
// PERFIL DO MORADOR
// ============================================================

class TelaPerfilMorador extends StatelessWidget {
  final String nome;

  const TelaPerfilMorador({
    super.key,
    required this.nome,
  });

  static const Color fundo = Color(0xFF5C5052);
  static const Color vermelho = Color(0xFFF5322C);
  static const Color vermelhoEscuro = Color(0xFFB7191D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,

      body: SafeArea(
        child: Column(
          children: [

            // ------------------------------------------------
            // TOPO
            // ------------------------------------------------

            Container(
              height: 65,
              color: vermelho,

              child: Row(
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    'Perfil do morador',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ------------------------------------------------
            // FOTO / PERFIL
            // ------------------------------------------------

            CircleAvatar(
              radius: 55,

              backgroundColor: Colors.white,

              child: Text(
                nome.substring(0, 1),

                style: const TextStyle(
                  color: vermelhoEscuro,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              nome,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------------
            // INFORMAÇÕES
            // ------------------------------------------------

            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF4D4446),
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Column(
                children: [

                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),

                      SizedBox(width: 12),

                      Text(
                        'Morador da rua',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),

                      SizedBox(width: 12),

                      Text(
                        'Comunidade',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ------------------------------------------------
            // BOTÃO VOLTAR
            // ------------------------------------------------

            Container(
              width: 190,
              height: 48,

              margin: const EdgeInsets.only(
                bottom: 30,
              ),

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: vermelhoEscuro,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25),
                  ),
                ),

                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}