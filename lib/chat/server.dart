import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4000);
  print('--- Servidor Online na Porta 4000 ---');

  await for (Socket client in server) {
    print('Novo cliente: ${client.remotePort}');

    // Corrigindo o erro de tipo: cast para List<int> antes do decoder
    client.cast<List<int>>().transform(utf8.decoder).listen(
      (data) {
        stdout.write('\nCliente: $data');
        stdout.write('Você: ');
      },
      onDone: () => print('\nConexão encerrada.'),
      onError: (e) => print('Erro: $e'),
    );

    // Stream do teclado para o cliente
    stdin.cast<List<int>>().transform(utf8.decoder).listen((text) {
      client.write(text);
      stdout.write('Você: ');
    });
  }
}