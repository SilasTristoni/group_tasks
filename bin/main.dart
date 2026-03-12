import 'dart:io';
// Importamos os teus exercícios usando prefixos (as ...)
import '../lib/biblioteca.dart' as lib;
import '../lib/clima.dart' as clima;
import '../lib/chat/server.dart' as server;
import '../lib/chat/cliente.dart' as cliente;

void main() async {
  bool continuar = true;

  while (continuar) {
    print('\n=========================================');
    print('       MENU DE EXERCÍCIOS - DART');
    print('=========================================');
    print('1 - Sistema de Biblioteca (POO)');
    print('2 - Consulta de Clima (API + Future)');
    print('3 - Iniciar Servidor de Chat (TCP)');
    print('4 - Iniciar Cliente de Chat (TCP)');
    print('0 - Sair');
    stdout.write('\nEscolha uma opção: ');

    String? opcao = stdin.readLineSync();

    print('\n-----------------------------------------');

    switch (opcao) {
      case '1':
        print('Executando: Sistema de Biblioteca\n');
        lib.main(); 
        break;
      case '2':
        print('Executando: Consulta de Clima\n');
        await clima.main(); // Usamos await porque a API é assíncrona
        break;
      case '3':
        print('Iniciando Servidor... (Pressione Ctrl+C para parar)');
        await server.main();
        break;
      case '4':
        print('Iniciando Cliente...');
        await cliente.main();
        break;
      case '0':
        print('A encerrar o sistema...');
        continuar = false;
        break;
      default:
        print('❌ Opção inválida. Tente novamente.');
    }
    
    if (continuar) {
      print('\n-----------------------------------------');
      stdout.write('Pressione ENTER para voltar ao menu...');
      stdin.readLineSync();
    }
  }
}