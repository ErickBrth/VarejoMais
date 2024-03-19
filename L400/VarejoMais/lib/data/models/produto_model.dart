class ProdutoModel {
  final String nome;
  final String valor_venda;
  final String imagem;
  final String estoque;
  final String id;

  ProdutoModel(
      {required this.id,
      required this.nome,
        required this.imagem,
      required this.valor_venda,
      required this.estoque});

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
        id: map["id"],
        nome: map["nome"],
        valor_venda: map["valor_venda"],
        imagem: map["foto"],
        estoque: map["estoque"]?? "0");
  }
}
