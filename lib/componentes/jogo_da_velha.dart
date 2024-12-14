import 'package:flutter/material.dart';
import 'dart:math'; //

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro =
      List.filled(9, ''); // acrescentado; para preencher o valor do tabuleiro
  String _jogador = 'X'; // acrescentado
  bool _contraMaquina = false; // acrescentado
  //
  final Random _randomico = Random();
  bool _pensando = false; //

  // trocar jogador para X e O
  void _trocaJogador() {
    setState(() {
      _jogador = _jogador == 'X' ? 'O' : 'X';
    });
  }

  // verificar vencedor
  bool verificaVencedor(String jogador) {
    const posicoesVencedoras = [
      [0, 1, 2], // matriz
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var posicoes in posicoesVencedoras) {
      if (_tabuleiro[posicoes[0]] == jogador &&
          _tabuleiro[posicoes[1]] == jogador &&
          _tabuleiro[posicoes[2]] == jogador) {
        _mostreDialogoVencedor(jogador); // Mostra o diálogo do vencedor
        return true;
      }
    }
    if (!_tabuleiro.contains('')) {
      // Verifica se o tabuleiro está cheio (empate)
      _mostreDialogoVencedor('Empate'); // Mostra o diálogo de empate
      return true;
    }
    return false; // Retorna false se o jogo continuar
  }

// jogada computador
  void _jogadaComputador() {
    //12
    //setState(() {
      //_pensando = true;
    //});
    setState(() => _pensando = true);
    //{
    
    //
    Future.delayed(const Duration(seconds: 1), () {
      int movimento;
      do {
        movimento = _randomico.nextInt(9);
      } while (_tabuleiro[movimento] != '');
      setState(() {
        _tabuleiro[movimento] = 'O';
        if (!verificaVencedor(_jogador)) {
          _trocaJogador();
        }
        // 12 
        _pensando = false;
      });
    });
  }

  // jogada
  void _jogada(int index) {
    if (_tabuleiro[index] == '') {
      // Verifica se a célula está vazia
      setState(() {
        _tabuleiro[index] = _jogador;
        if (!verificaVencedor(_jogador)) {
          _trocaJogador(); // Troca o jogador somente se o jogo continuar
          _jogadaComputador(); // Chame a função para a jogada do computador
        }
      });
    }
  }

  // mostrar diálogo vencedor
  void _mostreDialogoVencedor(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(vencedor == 'Empate' ? 'Empate!' : 'Vencedor: $vencedor'),
          actions: [
            ElevatedButton(
              child: const Text('Reiniciar Jogo'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _iniciarJogo(); // Reinicia o jogo
              },
            ),
          ],
        );
      },
    );
  }

  // reiniciar o jogo
  void _iniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, ''); // Reinicia o tabuleiro
      _jogador = 'X'; // Redefine o jogador inicial
    });
  }

  @override
  Widget build(BuildContext context) {
    // responsivo visual 01
    double altura = MediaQuery.of(context).size.height * 0.5;

    return Column(
      // responsivo 02
      children: [
        // 07
        Expanded(
          child: Row(
            children: [
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: _contraMaquina,
                  onChanged: (value) {
                    setState(() {
                      _contraMaquina = value;
                      _iniciarJogo();
                    });
                  },
                ),
              ),
              Text(_contraMaquina ? 'Contra Máquina' : 'Humano'),
              // 10
              const SizedBox(width: 30.0),
              if (_pensando)
              const SizedBox(
                height: 15.0,
                width: 15.0,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: // 06
              SizedBox(
            width: altura,
            height: altura,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de colunas
                crossAxisSpacing: 8.0, // Espaço entre colunas
                mainAxisSpacing: 5.0, // Espaço entre linhas
              ),
              itemCount: 9, // Número total de células
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _jogada(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100], // Cor de fundo das células
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _tabuleiro[index],
                        style: const TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: //08
              ElevatedButton(
            onPressed: _iniciarJogo,
            child: const Text('Reiniciar Jogo'),
          ),
        ),
      ],
    );
  }
}
