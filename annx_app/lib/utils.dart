String decimalAFraccion(String valor) {
  double numero = double.tryParse(valor) ?? 0;

  if (numero == 0.5) return "1/2";
  if (numero == 0.25) return "1/4";
  if (numero == 0.75) return "3/4";
  if (numero == 0.33) return "1/3";
  if (numero == 0.66) return "2/3";
  if (numero == 0.44) return "4/9";
  if (numero == 1.50) return "1 1/2";

  return valor; // si no coincide, deja el decimal
}
