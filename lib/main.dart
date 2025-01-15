import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _input = '';
  String _operator = '';
  double _num1 = 0;
  double _num2 = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '0';
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == '=' && _operator.isNotEmpty) {
        _num2 = double.parse(_input);
        switch (_operator) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case '*':
            _output = (_num1 * _num2).toString();
            break;
          case '/':
            _output = (_num1 / _num2).toString();
            break;
        }
        _input = _output;
        _operator = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        _num1 = double.parse(_input);
        _input = '';
        _operator = buttonText;
      } else {
        _input += buttonText;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                final buttons = [
                  '7', '8', '9', '/',
                  '4', '5', '6', '*',
                  '1', '2', '3', '-',
                  'C', '0', '=', '+',
                ];
                return ElevatedButton(
                  onPressed: () => _onButtonPressed(buttons[index]),
                  child: Text(
                    buttons[index],
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
