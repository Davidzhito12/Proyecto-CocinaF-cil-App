import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> recetas;

  @override
  void initState() {
    super.initState();
    recetas = apiService.obtenerRecetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocina Fácil'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido a Cocina Fácil',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Descubre recetas deliciosas y fáciles de preparar',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '¿Qué quieres cocinar hoy?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Buscador o barra de búsqueda
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar recetas...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Categorías
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _categoria('Desayuno', Icons.free_breakfast),
                  _categoria('Almuerzo', Icons.lunch_dining),
                  _categoria('Cena', Icons.dinner_dining),
                  _categoria('Postres', Icons.cake),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Sección de recetas
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recetas Populares',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Ver todas las recetas"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //Carta de las recetas
            _recetaCard(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      //Navbar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}

Widget _categoria(String nombre, IconData icono) {
  return Container(
    width: 120,
    margin: const EdgeInsets.only(right: 15),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.orange[100],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icono, size: 30, color: Colors.orange),
        const SizedBox(height: 10),
        Text(nombre, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}

Widget _recetaCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recetas populares",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Las más cocinadas esta semana",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}
