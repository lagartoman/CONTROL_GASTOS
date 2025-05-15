class Gasto {
  final int? id;
  final String descripcion;
  final String categoria;
  final double monto;
  final DateTime fecha;

  Gasto({
    this.id,
    required this.descripcion,
    required this.categoria,
    required this.monto,
    required this.fecha,
  });

  factory Gasto.fromJson(Map<String, dynamic> json) => Gasto(
    id: json['id'] as int?,
    descripcion: json['descripcion'] as String,
    categoria: json['categoria'] as String,
    monto: json['monto'] as double,
    fecha: DateTime.parse(json['fecha'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'descripcion': descripcion,
    'categoria': categoria,
    'monto': monto,
    'fecha': fecha.toIso8601String(),
  };
}