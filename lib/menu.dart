import 'package:flutter/material.dart';
import 'cards.dart';
void main() {
  runApp(const MyExampleCard());
}

class MyExampleCard extends StatelessWidget {
  const MyExampleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cards app'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 221, 237, 200),
          padding: const EdgeInsets.all(16.0),
          child: const Align(
            alignment: Alignment.topCenter,
            child: MyCard(),
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125.0,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 20,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(Icons.home, size: 30.0),
                  title: Text('Título'),
                  subtitle: Text(
                      'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      child: const Text('Ir'),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cancelar')),
                        );
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
