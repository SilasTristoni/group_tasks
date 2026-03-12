import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ClimaModel {
  final double temperatura;
  final int codigoClima;
  ClimaModel({required this.temperatura, required this.codigoClima});

  String get descricao {
    if (codigoClima == 0) return 'Céu Limpo';
    if (codigoClima <= 3) return 'Parcialmente Nublado';
    if (codigoClima >= 51 && codigoClima <= 67) return 'Chuva/Garoa';
    if (codigoClima >= 95) return 'Tempestade';
    return 'Nublado';
  }

  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    final atual = json['current_weather'];
    return ClimaModel(
      temperatura: atual['temperature'],
      codigoClima: atual['weathercode'],
    );
  }
}

// Serviço que faz a chamada à API (Open-Meteo - Gratuita)
class ClimaService {
  Future<ClimaModel> buscarClima(String lat, String lon) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true'
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return ClimaModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Erro no servidor (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Não foi possível obter o clima: $e');
    }
  }
}

Future<void> main() async {
  final service = ClimaService();

  print('=== SISTEMA DE CONSULTA DE CLIMA ===');
  print('\n📍 EXEMPLOS PARA TESTAR:');
  print('1. Joinville, SC     -> Lat: -26.30 | Lon: -48.84');
  print('2. São Paulo, SP     -> Lat: -23.55 | Lon: -46.63');
  print('3. Londres, UK       -> Lat: 51.50  | Lon: -0.12');
  print('4. Tóquio, JP        -> Lat: 35.68  | Lon: 139.65');
  print('------------------------------------');

  stdout.write('\nDigite a LATITUDE: ');
  String? lat = stdin.readLineSync();

  stdout.write('Digite a LONGITUDE: ');
  String? lon = stdin.readLineSync();

  if (lat == null || lon == null || lat.isEmpty || lon.isEmpty) {
    print('❌ Erro: Deves introduzir valores válidos.');
    return;
  }

  print('\nA pesquisar...');

  try {
    final resultado = await service.buscarClima(lat, lon);
    print('\n✅ SUCESSO!');
    print('🌡️  Temperatura: ${resultado.temperatura}°C');
    print('☁️  Condição: ${resultado.descricao}');
  } catch (e) {
    print('\n⚠️  ERRO: ${e.toString()}');
  }
}