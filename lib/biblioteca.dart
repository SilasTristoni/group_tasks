// 1. Classe Base (Superclasse)
class ItemBiblioteca {
  String titulo;
  String autor;
  int ano;
  bool estaEmprestado = false;

  ItemBiblioteca(this.titulo, this.autor, this.ano);

  void exibirInfo() {
    print("-----------------------------");
    print("Título: $titulo");
    print("Autor: $autor ($ano)");
    print("Status: ${estaEmprestado ? 'Emprestado' : 'Disponível'}");
  }

  void emprestar() {
    estaEmprestado = true;
    print("O item '$titulo' foi emprestado.");
  }
}

// 2. Subclasse Livro
class Livro extends ItemBiblioteca {
  String isbn;
  int numPaginas;

  // Construtor que repassa dados para o pai (super)
  Livro(String titulo, String autor, int ano, this.isbn, this.numPaginas) 
      : super(titulo, autor, ano);

  @override
  void exibirInfo() {
    super.exibirInfo(); // Chama o método da classe pai
    print("Tipo: LIVRO | ISBN: $isbn | Páginas: $numPaginas");
  }
}

// 3. Subclasse Revista
class Revista extends ItemBiblioteca {
  int edicao;

  Revista(String titulo, String autor, int ano, this.edicao) 
      : super(titulo, autor, ano);

  @override
  void exibirInfo() {
    super.exibirInfo();
    print("Tipo: REVISTA | Edição: $edicao");
  }
}

void main() {
  var meuLivro = Livro("1984", "George Orwell", 1949, "978-0451524935", 328);
  var minhaRevista = Revista("Superinteressante", "Abril", 2024, 450);

  meuLivro.emprestar();
  
  meuLivro.exibirInfo();
  minhaRevista.exibirInfo();
}