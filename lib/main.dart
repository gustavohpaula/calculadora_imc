import 'package:flutter/material.dart';

void main() {
  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({super.key});

  @override
  State<IMCCalculator> createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  double? _imc;
  String _mensagem = '';

  void _calcularIMC() {
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    final double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));

    if (altura == null || peso == null || altura <= 0 || peso <= 0) {
      setState(() {
        _mensagem = 'Por favor, insira valores válidos.';
        _imc = null;
      });
      return;
    }

    final imc = peso / (altura * altura);
    String classificacao;
    Color cor;

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
      cor = Colors.blue;
    } else if (imc < 25) {
      classificacao = 'Peso ideal';
      cor = Colors.green;
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
      cor = Colors.orange;
    } else if (imc < 35) {
      classificacao = 'Obesidade grau I';
      cor = Colors.deepOrange;
    } else if (imc < 40) {
      classificacao = 'Obesidade grau II';
      cor = Colors.red;
    } else {
      classificacao = 'Obesidade grau III';
      cor = Colors.red.shade900;
    }

    setState(() {
      _imc = imc;
      _mensagem = classificacao;
    });
  }
    void _limparCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _imc = null;
      _mensagem = '';
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _limparCampos,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('Limpar Campos'),
            ),
            const SizedBox(height: 32),
            if (_imc != null)
              Column(
                children: [
                  Text(
                    'Seu IMC é: ${_imc!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _mensagem,
                    style: TextStyle(
                      fontSize: 20,
                      color: _getColor(_imc!),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getColor(double imc) {
    if (imc < 18.5) return Colors.orange;
    if (imc < 24.9) return Colors.green;
    if (imc < 29.9) return Colors.yellow.shade700;
    return Colors.red;
  }
}
