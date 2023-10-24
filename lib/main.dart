import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infTest = "Informe os seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infTest =
          "Informe os seus dados"; // reset tds os resultados e a informaçao
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infTest = "Está abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infTest = "Peso Ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infTest = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infTest = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infTest = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 39.9) {
        _infTest = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.5),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(Icons.person_outline,
                size: 120.5, color: Colors.blueGrey),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (KG)',
                labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
              controller: weightController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Insira o seu Peso!!';
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
              controller: heightController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Insira a sua altura!!';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.5),
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculate();
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueGrey)),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 23.0),
                  ),
                ),
              ),
            ),
            Text(_infTest,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                textAlign: TextAlign.center)
          ]),
        ),
      ),
    );
  }
}
