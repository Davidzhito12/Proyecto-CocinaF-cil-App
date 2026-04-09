import 'package:flutter/material.dart';
import '../home/app_main_screen.dart';

class AuthFlowScreen extends StatefulWidget {
  const AuthFlowScreen({super.key});

  @override
  State<AuthFlowScreen> createState() => _AuthFlowScreenState();
}

enum AuthStage { welcome, authOptions, completed }

class _AuthFlowScreenState extends State<AuthFlowScreen> {
  AuthStage _stage = AuthStage.welcome;

  void _goToAuthOptions() => setState(() => _stage = AuthStage.authOptions);
  void _goToCompleted() => setState(() => _stage = AuthStage.completed);

  void _goToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AppMainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    switch (_stage) {
      case AuthStage.welcome:
        return _buildWelcomeScreen();
      case AuthStage.authOptions:
        return _buildAuthOptionsScreen();
      case AuthStage.completed:
        return _buildCompletedScreen();
    }
  }

  Widget _buildWelcomeScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFFF9900), const Color(0xFFFF7A00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: const Icon(Icons.restaurant_menu, size: 70, color: Color(0xFFFF9900)),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'CocinaFacil',
                    style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descubre recetas deliciosas\ny fáciles de preparar',
                    style: TextStyle(color: Colors.white, fontSize: 18, height: 1.6, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: _goToAuthOptions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF9900),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 10,
                    ),
                    child: const Text('Comenzar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: _goToAuthOptions,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Entrar con cuenta existente', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthOptionsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => _stage = AuthStage.welcome)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text('Elige tu forma de registrarte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 24),
              _buildAuthButton(
                icon: Icons.g_mobiledata,
                label: 'Continúa con Google',
                backgroundColor: Colors.black,
                onPressed: _goToCompleted,
              ),
              const SizedBox(height: 12),
              _buildAuthButton(
                icon: Icons.facebook,
                label: 'Continúa con Facebook',
                backgroundColor: const Color(0xFF1877F2),
                onPressed: _goToCompleted,
              ),
              const SizedBox(height: 12),
              _buildAuthButton(
                icon: Icons.email_outlined,
                label: 'Continúa con correo',
                backgroundColor: const Color(0xFFFF9900),
                onPressed: _goToCompleted,
              ),
              const SizedBox(height: 12),
              _buildAuthButton(
                icon: Icons.apple,
                label: 'Continúa con Apple',
                backgroundColor: Colors.black,
                onPressed: _goToCompleted,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Al registrarte aceptas nuestros Términos de Servicio y Política de Privacidad. CocinaFacil es seguro y confiable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }

  Widget _buildCompletedScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFFF9900).withAlpha(20), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9900),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ahora puedes explorar mejores recetas cocinadas por expertos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 15)],
                    ),
                    child: const Column(
                      children: [
                        _BenefitItem(icon: Icons.book, text: 'Recetas paso a paso'),
                        SizedBox(height: 16),
                        _BenefitItem(icon: Icons.star, text: 'Recetas valoradas'),
                        SizedBox(height: 16),
                        _BenefitItem(icon: Icons.group, text: 'Comunidad activa'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: _goToHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9900),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                    ),
                    child: const Text('Empezar a cocinar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9900).withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFF9900), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
        ),
      ],
    );
  }
}

