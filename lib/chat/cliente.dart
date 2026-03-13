import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  try {
    final socket = await Socket.connect('127.0.0.1', 4000);
    print('--- Conectado ao Chat ---');
    print('Digite "sair" e pressione ENTER para encerrar.');
    stdout.write('Você: ');

    final completer = Completer<void>();

    socket.cast<List<int>>().transform(utf8.decoder).listen(
      (data) {
        stdout.write('\rServidor: $data');
        stdout.write('Você: ');
      },
      onDone: () {
        print('\nConexão encerrada pelo servidor.');
        if (!completer.isCompleted) completer.complete();
      },
      onError: (e) {
        print('\nErro na conexão: $e');
        if (!completer.isCompleted) completer.complete();
      },
    );

    final stdinSub = stdin.cast<List<int>>().transform(utf8.decoder).listen((text) {
      if (text.trim().toLowerCase() == 'sair') {
        if (!completer.isCompleted) completer.complete();
      } else {
        socket.write(text);
        stdout.write('Você: ');
      }
    });

    await completer.future;
    await stdinSub.cancel();
    socket.destroy();
 
    exit(0); 
  } catch (e) {
    print('Erro na conexão: $e');
  }
}