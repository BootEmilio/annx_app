class Alimento {
  final int id;
  final String nombre;
  final int grupoId;
  final String energia;
  final String proteina;
  final String carbohidratos;
  final String grasa;

  // 👇 NUEVOS CAMPOS
  final String cantidadSugerida;
  final String unidad;
  final String pesoBruto;
  final String pesoNeto;

  Alimento({
    required this.id,
    required this.nombre,
    required this.grupoId,
    required this.energia,
    required this.proteina,
    required this.carbohidratos,
    required this.grasa,
    required this.cantidadSugerida,
    required this.unidad,
    required this.pesoBruto,
    required this.pesoNeto,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      id: json['id'],
      nombre: json['nombre'],
      grupoId: json['grupo_id'],
      energia: json['energia'] ?? "0",
      proteina: json['proteina'] ?? "0",
      carbohidratos: json['hidratos_carbono'] ?? "0",
      grasa: json['lipidos'] ?? "0",

      // 👇 MAPEO NUEVO
      cantidadSugerida: json['cantidad_sugerida'] ?? "0",
      unidad: json['unidad'] ?? "",
      pesoBruto: json['peso_bruto'] ?? "0",
      pesoNeto: json['peso_neto'] ?? "0",
    );
  }
}