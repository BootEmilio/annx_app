import 'package:flutter/material.dart';
import 'api_service.dart';
import 'alimento.dart';
import 'utils.dart';

class AlimentosPage extends StatefulWidget {
  final int grupoId;
  final String nombreGrupo;

  const AlimentosPage({
    super.key,
    required this.grupoId,
    required this.nombreGrupo,
  });

  @override
  State<AlimentosPage> createState() => _AlimentosPageState();
}

class _AlimentosPageState extends State<AlimentosPage> {
  
  List<Alimento> listaCompleta = [];
  List<Alimento> listaFiltrada = [];
  bool cargando = true;


  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    final data = await ApiService().obtenerAlimentosPorGrupo(widget.grupoId);

    setState(() {
      listaCompleta = data;
      listaFiltrada = data;
      cargando = false;
    });
  }

  void filtrar(String query) {
  final resultados = listaCompleta.where((alimento) {
    return alimento.nombre
        .toLowerCase()
        .contains(query.toLowerCase());
  }).toList();

  setState(() {
    listaFiltrada = resultados;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombreGrupo),
      ),
      body: cargando
    ? const Center(child: CircularProgressIndicator())
    : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: filtrar,
              decoration: InputDecoration(
                hintText: "Buscar alimento...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Expanded(
            child: listaFiltrada.isEmpty
                ? const Center(child: Text("No hay resultados"))
                : ListView.builder(
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final alimento = listaFiltrada[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(alimento.nombre),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Cantidad: ${decimalAFraccion(alimento.cantidadSugerida)} ${alimento.unidad}"),
                              Text("Peso bruto: ${alimento.pesoBruto} g"),
                              Text("Peso neto: ${alimento.pesoNeto} g"),
                              const SizedBox(height: 5),
                              Text("Energía: ${alimento.energia} kcal"),
                              Text("Proteína: ${alimento.proteina} g"),
                              Text("Carbohidratos: ${alimento.carbohidratos} g"),
                              Text("Grasa: ${alimento.grasa} g"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


