import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//o widget principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Lista de Compras',
      theme: ThemeData(
        //essa cor aparece apenas no drawer menu
        primarySwatch: Colors.blue,
      ),
      home: ShoppingListScreen(),
    );
  }
}

// tela que exibe a lista
class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  // lista que armazena os itens da lista de compras
  List<String> shoppingList = [];

  // metodo para adicionar um item
  void addItem(String item) {
    setState(() {
      shoppingList.add(item);
    });
  }

  // metodo para remover um item
  void removeItem(int index) {
    setState(() {
      shoppingList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar com titulo e botao para adicionar item
      appBar: AppBar(
        title: Text('Minha Lista de Compras'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            // abre a tela de adicionar algo
            onPressed: () async {
              final newItem = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemScreen(),
                ),
              );
              if (newItem != null) {
                addItem(newItem); // adiciona o item
              }
            },
          ),
        ],
      ),
      // drawer com opções.
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // opção home
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // opção sobre
            ListTile(
              title: Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('App para Gerenciar Compras')),
                ); // exive a mensagem embaixo
              },
            ),
          ],
        ),
      ),
      // corpo da tela lista de compras
      body: ListView.builder(
        itemCount: shoppingList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(shoppingList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeItem(index),
            ),
          );
        },
      ),
    );
  }
}

// tela adicionar um item
class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _controller = TextEditingController();

  void saveItem() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      Navigator.pop(context, text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item adicionado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar do adicionador
      appBar: AppBar(
        title: Text('Adicionar Item'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveItem,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nome do Item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveItem,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
