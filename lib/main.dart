import 'package:flutter/material.dart';
import 'package:myapp/componentes/jogo_da_velha.dart';
//import 'calculadora.dart'; //

void main() {
  runApp(const App()); // Chamar a classe App
}

class App extends StatelessWidget {
  const App({super.key});

// mudar aqui
  @override
  Widget build(BuildContext context) {
    const String titulo = 'Jogo Da Velha no Flutter!';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Jogo da velha',
      title: titulo,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: titulo), // Definindo a HomePage
      //  home: const HomePage(title: 'Jogo Da Velha no Flutter!'), // Definindo a HomePage
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // Aqui, você pode colocar qualquer conteúdo adicional
                // como texto ou outros widgets
              ),
            ),
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(), // Primeira coluna, espaço vazio
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.black, width: 8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(10, 25),
                          ),
                        ],
                      ),
                      //  child: const JogoDaVelha()
                      // mudar para jogo da velha
                      // padding: deixar espaço no meio do quadrado
                      // ignore: prefer_const_constructors
                      child: const Padding(
                        // padding: EdgeInsets.all(10.0),
                        // padding: EdgeInsets.only(top:10.0),
                        //padding: EdgeInsets.only(left:10.0),
                        //padding: EdgeInsets.only(right:10.0),
                        //padding: EdgeInsets.symmetric(horizontal:10.0),
                        padding: EdgeInsets.all(10.0),
                        child: JogoDaVelha(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(), // Terceira coluna, espaço vazio
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                // Layout inferior
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add), // ícone do botão
      ),
    );
  }
}
