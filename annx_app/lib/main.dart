import 'package:flutter/material.dart';
import 'api_service.dart';
import 'categoria.dart';
import 'alimentos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CategoriasPage(),
    );
  }
}

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  late Future<List<Categoria>> categorias;

  @override
  void initState() {
    super.initState();
    categorias = ApiService().obtenerCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: FutureBuilder<List<Categoria>>(
        future: categorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos'));
          }

          final lista = snapshot.data!;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final categoria = lista[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(categoria.id.toString()),
                  ),
                  title: Text(categoria.nombre),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlimentosPage(
                          grupoId: categoria.id,
                          nombreGrupo: categoria.nombre,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}