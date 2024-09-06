class AcountNequi {
  final String name;
  final String tlf;
  final String? seguritiCode;

  static const String bdName = 'nequi-account';

  AcountNequi({
    required this.name,
    required this.tlf,
    this.seguritiCode,
  });

  // Convert AcuntNequi to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'tlf': tlf,
        'seguritiCode': seguritiCode,
      };

  // Create AcuntNequi from JSON
  factory AcountNequi.fromJson(Map<String, dynamic> json) => AcountNequi(
        name: json['name'],
        tlf: json['tlf'],
        seguritiCode: json['seguritiCode'],
      );
}
