import 'dart:io';

class Funcionario {
  String nome; 
  String? apelido; 
  String cargo;
  double salario;
  String? telefone; 

  Funcionario({
    required this.nome,
    this.apelido,
    required this.cargo,
    required this.salario,
    this.telefone,
  });

  void exibirDetalhes() {
    print('\n--- Perfil do Funcionário ---');
    print('Nome: $nome (Conhecido como: ${apelido ?? "Sem apelido"})');
    print('Cargo: $cargo');
    print('Salário: R\$ ${salario.toStringAsFixed(2)}');
    
    if (telefone != null) {
      print('Contato: $telefone');
    } else {
      print('Contato: Não informado');
    }
  }
}

class BancoDeDadosRH {
  final Map<int, Funcionario> _funcionarios = {
    1: Funcionario(
        nome: 'João Silva', 
        cargo: 'Desenvolvedor', 
        salario: 5000.0, 
        telefone: '47999999999'),
    2: Funcionario(
        nome: 'Maria Souza', 
        apelido: 'Mari', 
        cargo: 'Designer', 
        salario: 4500.0), 
  };

  Funcionario? buscarFuncionario(int id) {
    return _funcionarios[id]; 
  }
}

void main() {
  print('\n=== SISTEMA DE RH (NULL SAFETY) ===');
  var db = BancoDeDadosRH();

  stdout.write('Digite o ID do funcionário para buscar (Ex: 1 ou 2, ou 3 para testar erro nulo): ');
  
  String? entrada = stdin.readLineSync();

  int idBusca = int.tryParse(entrada ?? '') ?? 0;

  Funcionario? funcionarioEncontrado = db.buscarFuncionario(idBusca);

  if (funcionarioEncontrado != null) {
    funcionarioEncontrado.exibirDetalhes();
    
    int tamanhoNome = funcionarioEncontrado.nome.length;
    int? tamanhoApelido = funcionarioEncontrado.apelido?.length;
    
    print('\n[Info Extra] O nome tem $tamanhoNome letras.');
    print('[Info Extra] O apelido tem ${tamanhoApelido ?? 0} letras.');

  } else {
    print('\n❌ Funcionário com ID $idBusca não encontrado no sistema (Retornou Null).');
  }
}