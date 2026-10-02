import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool mostrarSenha = false;
  bool aceitouTermos = false;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
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
            // Fundo
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF991D19),
            ),

            // Círculo superior esquerdo
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

            // Forma central/direita
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

            // Círculo inferior esquerdo
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

            // Círculo inferior direito
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

            Container(
              width: 105,
              height: 105,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/ciconeroda.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 52),

            // Título
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 12),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'E-mail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 2),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Username@email.com',
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
              ),
            ),

            const SizedBox(height: 17),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Senha',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 2),

            TextField(
              controller: senhaController,
              obscureText: !mostrarSenha,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'xxxxxxxx',
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                  icon: Icon(
                    mostrarSenha ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ),
            ),

            // Esqueci minha senha
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navegação será adicionada depois.
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.white, fontSize: 7),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Botão Próximo
            SizedBox(
              width: double.infinity,
              height: 28,
              child: ElevatedButton(
                onPressed: () {
                  // A navegação será adicionada depois.
                  //
                  // Aqui futuramente vamos:
                  // 1. validar e-mail e senha;
                  // 2. enviar para o backend;
                  // 3. verificar o usuário no banco;
                  // 4. ir para a próxima tela.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7191E),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Próximo',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Termos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Checkbox(
                    value: aceitouTermos,
                    onChanged: (valor) {
                      setState(() {
                        aceitouTermos = valor ?? false;
                      });
                    },
                    side: const BorderSide(color: Colors.white, width: 1),
                    checkColor: const Color(0xFFE52F29),
                    activeColor: Colors.white,
                  ),
                ),
                const Flexible(
                  child: Text(
                    'Li e aceito os Termos de Uso e a Política de Privacidade',
                    style: TextStyle(color: Colors.white, fontSize: 6.5),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Opções inferiores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Página do prestador futuramente.
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Prestador de serviço',
                    style: TextStyle(color: Colors.white, fontSize: 6.5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Página de cadastro futuramente.
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Não tem conta? Cadastre-se',
                    style: TextStyle(color: Colors.white, fontSize: 6.5),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
