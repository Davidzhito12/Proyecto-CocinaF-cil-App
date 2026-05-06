import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recipes/all_recipes_screen.dart';
import 'package:flutter_application_1/screens/favorites/favorites_screen.dart';
import '../../nn.dart';

const List<Map<String, String>> topSearchItems = [
  {'title': 'Almuerzo', 'image': 'lib/image/almuerzo.png'},
  {'title': 'Desayuno', 'image': 'lib/image/desayuno_saludable.png'},
  {'title': 'Cena', 'image': 'lib/image/cena.png'},
  {'title': 'Galletas', 'image': 'lib/image/galletas.png'},
  {'title': 'Almuerzo casero', 'image': 'lib/image/almuerzo_casero.png'},
  {'title': 'Desayunos', 'image': 'lib/image/desayuno_saludable.png'},
  {'title': 'Pollo', 'image': 'lib/image/pollo_broaster_casero.png'},
  {'title': 'Sopas', 'image': 'lib/image/sopas.png'},
  {'title': 'Espagueti', 'image': 'lib/image/espagueti.png'},
];

const List<Map<String, String>> premiumItems = [
  {'title': 'Recetas Populares', 'subtitle': 'Las más cocinadas esta semana', 'image': 'lib/image/almuerzo.png'},
  {'title': 'Recetas Fáciles', 'subtitle': 'Para principiantes', 'image': 'lib/image/desayuno_saludable.png'},
];

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _selectedIndex = 0;
  String _userName = 'Ali David Gonzalez Macea';
  String _userHandle = '@cook_115836130';
  String _userEmail = 'cook_115836130@example.com';
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoUpdateEnabled = false;

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('ali david gonzalez macea', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Text('@cook_115836130', style: TextStyle(fontSize: 14, color: Colors.grey)),
                const Divider(height: 24),
                _profileMenuItem(context, Icons.person, 'Perfil'),
                _profileMenuItem(context, Icons.group, 'Mi Red'),
                _profileMenuItem(context, Icons.bar_chart, 'Estadísticas'),
                _profileMenuItem(context, Icons.history, 'Recetas vistas recientemente'),
                _profileMenuItem(context, Icons.workspace_premium, 'Premium'),
                _profileMenuItem(context, Icons.flag, 'Desafíos'),
                _profileMenuItem(context, Icons.settings, 'Ajustes'),
                _profileMenuItem(context, Icons.help, 'Preguntas frecuentes'),
                _profileMenuItem(context, Icons.send, 'Enviar opinión'),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _profileMenuItem(BuildContext context, IconData icon, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: kprimarycolor),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        if (label == 'Perfil') {
          _openProfileScreen();
          return;
        }
        if (label == 'Ajustes') {
          setState(() => _selectedIndex = 3);
          return;
        }
        if (label == 'Preguntas frecuentes') {
          _openHelpSupport();
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label seleccionado')));
      },
    );
  }

  void _openAllRecipes() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AllRecipesScreen()));
  }

  void _openProfileScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ProfileScreen(
        name: _userName,
        email: _userEmail,
        onSave: (name, email) {
          setState(() {
            _userName = name;
            _userEmail = email;
          });
        },
      ),
    ));
  }

  void _openEmailDetails() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Correo electrónico'),
          content: Text('$_userEmail\n\nEste correo se usa para notificaciones y soporte.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cerrar')),
          ],
        );
      },
    );
  }

  void _openHelpSupport() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
  }

  void _showAboutApp() {
    showAboutDialog(
      context: context,
      applicationName: 'Cocina Fácil',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 Cocina Fácil',
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text('Descubre recetas, guarda favoritos y administra tu perfil desde la app.'),
        ),
      ],
    );
  }

  void _logout() {
    setState(() {
      _userName = 'Usuario';
      _userEmail = 'cook_115836130@example.com';
      _notificationsEnabled = false;
      _darkModeEnabled = false;
      _autoUpdateEnabled = false;
      _selectedIndex = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsScreen() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: kprimarycolor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.settings, color: Color(0xFFFF9900), size: 36),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ajustes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Administra tu perfil y preferencias', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Color(0xFFFF9900)),
                  title: const Text('Perfil'),
                  subtitle: Text(_userName),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: _openProfileScreen,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email, color: Color(0xFFFF9900)),
                  title: const Text('Correo electrónico'),
                  subtitle: Text(_userEmail),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: _openEmailDetails,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibe alertas de nuevas recetas y ofertas'),
                  value: _notificationsEnabled,
                  activeColor: const Color(0xFFFF9900),
                  onChanged: (value) => setState(() => _notificationsEnabled = value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Modo oscuro'),
                  subtitle: const Text('Activa un tema más cómodo para la noche'),
                  value: _darkModeEnabled,
                  activeColor: const Color(0xFFFF9900),
                  onChanged: (value) => setState(() => _darkModeEnabled = value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Actualizaciones automáticas'),
                  subtitle: const Text('Descarga contenido y mejoras automáticamente'),
                  value: _autoUpdateEnabled,
                  activeColor: const Color(0xFFFF9900),
                  onChanged: (value) => setState(() => _autoUpdateEnabled = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Color(0xFFFF9900)),
                  title: const Text('Ayuda y soporte'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: _openHelpSupport,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Color(0xFFFF9900)),
                  title: const Text('Acerca de la app'),
                  subtitle: const Text('Versión 1.0.0'),
                  onTap: _showAboutApp,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Color(0xFFFF9900)),
                  title: const Text('Cerrar sesión'),
                  onTap: _confirmLogout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Expanded(child: _buildBodyContent()),
                ],
              ),
            )
          : _selectedIndex == 1
              ? const FavoritesScreen()
              : _selectedIndex == 2
                  ? SafeArea(
                      child: Center(
                        child: Text(
                          'Mi menú',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : _buildSettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        elevation: 10,
        iconSize: 26,
        selectedItemColor: kprimarycolor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Mi menú'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF9900), const Color(0xFFFF7A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hola, usuario', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    Text('¿Qué  cocinarás hoy?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showProfileMenu(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 8)],
                    ),
                    child: const Icon(Icons.person, color: Color(0xFFFF9900), size: 28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10)],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar recetas...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: const Icon(Icons.tune, color: Color(0xFFFF9900)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Categorías populares', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(child: const Text('Ver más'), onPressed: () => _openAllRecipes()),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: topSearchItems.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = topSearchItems[index];
                return _buildSearchCard(item['title']!, item['image']!);
              },
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recetas destacadas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(child: const Text('Ver todas'), onPressed: () => _openAllRecipes()),
            ],
          ),
          const SizedBox(height: 12),
          ...premiumItems.map((item) => _buildRecipeCard(item)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchCard(String title, String imageUrl) {
    return GestureDetector(
      onTap: _openAllRecipes,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300, child: const Icon(Icons.image, color: Colors.grey)),
              ),
              Container(color: Colors.black.withAlpha(60)),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () => _openAllRecipes(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    item['image']!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 160, color: Colors.grey.shade300),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9900),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Popular', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 6),
                    Text(item['subtitle']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        const Text('30 min', style: TextStyle(fontSize: 13, color: Colors.grey)),
                        const SizedBox(width: 16),
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        const Text('4 porciones', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final void Function(String name, String email) onSave;

  const ProfileScreen({super.key, required this.name, required this.email, required this.onSave});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    widget.onSave(_nameController.text.trim(), _emailController.text.trim());
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil actualizado')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.email)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF9900)),
              onPressed: _saveProfile,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text('Guardar cambios', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda y soporte'),
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Preguntas frecuentes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              title: Text('¿Cómo guardo una receta como favorita?'),
              subtitle: Text('Toca el corazón en la pantalla de receta para agregarla a Favoritos.'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              title: Text('¿Dónde veo mis recetas guardadas?'),
              subtitle: Text('Ve a la pestaña Favoritos en la barra inferior.'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              title: Text('¿Cómo cambio mi información?'),
              subtitle: Text('Edita tu nombre y correo desde Perfil en Ajustes.'),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const ListTile(
            leading: Icon(Icons.email, color: Color(0xFFFF9900)),
            title: Text('support@cocinafacil.app'),
          ),
          const ListTile(
            leading: Icon(Icons.phone, color: Color(0xFFFF9900)),
            title: Text('+57 300 000 0000'),
          ),
        ],
      ),
    );
  }
}
