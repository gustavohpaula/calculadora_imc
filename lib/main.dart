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

    setState(() {
      _imc = imc;
      if (imc < 18.5) {
        _mensagem = 'Abaixo do peso';
      } else if (imc < 24.9) {
        _mensagem = 'Peso normal';
      } else if (imc < 29.9) {
        _mensagem = 'Sobrepeso';
      } else {
        _mensagem = 'Obesidade';
      }
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularIMC,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Calcular IMC'),
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
