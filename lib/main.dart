// Importando o pacote flutter/material.dart
import 'package:flutter/material.dart';

// Função principal para iniciar o aplicativo
void main() {
  runApp(MyApp());
}

// Classe Item para representar um item na lista de compras
class Item {
  String name; // Nome do item
  bool checked; // Indica se o item está marcado como selecionado
  int count; // Contador para o número do item na lista

  // Construtor da classe Item
  Item(this.name, {this.checked = false, this.count = 0});
}

// Classe MyApp que define o aplicativo Flutter
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retorna o MaterialApp, que é a estrutura básica do aplicativo
    return MaterialApp(
      title: 'Lista de Compras', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor primária do tema
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListaCompras(), // Define a tela inicial como ListaCompras
    );
  }
}

// Classe ListaCompras que define a tela de lista de compras
class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

// Classe _ListaComprasState que define o estado da tela de lista de compras
class _ListaComprasState extends State<ListaCompras> {
  List<Item> _itens = []; // Lista de itens
  TextEditingController _controller =
      TextEditingController(); // Controlador para o campo de texto

  // Método para adicionar um novo item à lista
  void _adicionarItem(String nome) {
    // Verifica se o nome do item não está vazio
    if (nome.trim().isEmpty) {
      return; // Retorna sem adicionar o item se estiver vazio
    }

    // Atualiza o estado do widget com o novo item adicionado
    setState(() {
      _itens
          .add(Item(nome, count: _itens.length + 1)); // Adiciona o item à lista
    });
    _controller.clear(); // Limpa o campo de texto após adicionar o item
  }

  // Método para remover um item da lista
  void _removerItem(int index) {
    // Atualiza o estado do widget removendo o item da lista
    setState(() {
      _itens.removeAt(index);
    });
  }

  // Método para atualizar o estado de seleção de um item
  void _atualizarItem(int index, bool novoEstado) {
    // Atualiza o estado do widget com o novo estado de seleção do item
    setState(() {
      _itens[index].checked = novoEstado;
    });
  }

  // Método para ordenar os itens da lista
  void _ordenarItens() {
    // Atualiza o estado do widget ordenando os itens da lista
    setState(() {
      _itens.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  // Método build que constrói a interface do usuário da tela
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura do Scaffold, que define a estrutura da tela
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'), // Título da barra de navegação
        actions: [
          IconButton(
            icon: Icon(Icons.sort), // Ícone de classificação
            onPressed:
                _ordenarItens, // Define a ação ao pressionar o ícone de classificação
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _itens.length, // Número de itens na lista
        itemBuilder: (context, index) {
          final item = _itens[index]; // Obtém o item na posição atual
          return CheckboxListTile(
            title: Text(
                '${item.name} (Item ${item.count})'), // Título do item na lista
            value: item.checked, // Valor de seleção do item
            onChanged: (value) {
              _atualizarItem(index,
                  value!); // Atualiza o estado de seleção do item ao alterar o valor
            },
            secondary: IconButton(
              icon: Icon(Icons.delete), // Ícone de exclusão
              onPressed: () {
                _removerItem(
                    index); // Define a ação ao pressionar o ícone de exclusão
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abre um diálogo para adicionar um novo item
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar Item'), // Título do diálogo
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      labelText:
                          'Nome do Item'), // Campo de texto para inserir o nome do item
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Fecha o diálogo ao pressionar o botão de cancelar
                    },
                    child: Text('Cancelar'), // Texto do botão de cancelar
                  ),
                  TextButton(
                    onPressed: () {
                      _adicionarItem(_controller
                          .text); // Adiciona o item à lista ao pressionar o botão de adicionar
                      Navigator.pop(
                          context); // Fecha o diálogo após adicionar o item
                    },
                    child: Text('Adicionar'), // Texto do botão de adicionar
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add), // Ícone do botão de adicionar
      ),
    );
  }
}
