import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  try {
    final socket = await Socket.connect('127.0.0.1', 4000);
    print('--- Conectado ao Chat ---');

    // Escuta o servidor com o cast necessário
    socket.cast<List<int>>().transform(utf8.decoder).listen(
      (data) {
        stdout.write('\nServidor: $data');
        stdout.write('Você: ');
      },
      onDone: () => exit(0),
    );

    // Envia para o servidor
    stdin.cast<List<int>>().transform(utf8.decoder).listen((text) {
      socket.write(text);
      stdout.write('Você: ');
    });

    stdout.write('Você: ');
  } catch (e) {
    print('Erro na conexão: $e');
  }
}