import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/myButton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    userAnswer,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.blue[100],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                //clear button
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userInput = '';
                        userAnswer = '';
                      });
                    },
                    color: Colors.green,
                    label: buttons[index],
                    textColor: Colors.blue[50],
                  );
                  //delete button
                } else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userInput = userInput.substring(
                          0,
                          userInput.length - 1,
                        );
                        userAnswer = '';
                      });
                    },
                    color: Colors.red,
                    label: buttons[index],
                    textColor: Colors.blue[50],
                  );
                  // equal button
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    color: Colors.blueAccent[700],
                    label: buttons[index],
                    textColor: Colors.blue[50],
                  );
                }
                return MyButton(
                  buttonTapped: () {
                    setState(() {
                      userInput += buttons[index];
                    });
                  },
                  color: isOperator(buttons[index])
                      ? Colors.blueAccent[700]
                      : Colors.blue[50],
                  label: buttons[index],
                  textColor: isOperator(buttons[index])
                      ? Colors.blue[50]
                      : Colors.blueAccent[700],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    // (1) Parse expression:
    String finalQusetion = userInput;
    finalQusetion = finalQusetion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQusetion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
