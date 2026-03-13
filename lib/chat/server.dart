import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4000);
  print('--- Servidor Online na Porta 4000 ---');
  print('Aguardando cliente se conectar...');

  // Loop para aguardar a conexão
  await for (Socket client in server) {
    print('\nNovo cliente conectado: ${client.remotePort}');
    print('Digite "sair" e pressione ENTER para encerrar o chat.');
    stdout.write('Você: ');

    final completer = Completer<void>();

    client.cast<List<int>>().transform(utf8.decoder).listen(
      (data) {
        stdout.write('\rCliente: $data');
        stdout.write('Você: ');
      },
      onDone: () {
        print('\nCliente desconectou.');
        if (!completer.isCompleted) completer.complete();
      },
      onError: (e) {
        print('\nErro com o cliente: $e');
        if (!completer.isCompleted) completer.complete();
      },
    );

    final stdinSub = stdin.cast<List<int>>().transform(utf8.decoder).listen((text) {
      if (text.trim().toLowerCase() == 'sair') {
        if (!completer.isCompleted) completer.complete();
      } else {
        client.write(text);
        stdout.write('Você: ');
      }
    });

    await completer.future;

    await stdinSub.cancel();
    client.destroy();
    
    print('\nEncerrando servidor...');
    break;
  }
  
  await server.close();
  exit(0); 
}