// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/operations.dart';
import 'package:to_dont_list/widgets/basic_buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final List<Item> items = [];
  String displayText = "";
  String currentText = "";
  final Operation operation = Operation();

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = "";
        currentText = "";
        operation.clear();

      } else if (value == '+' || value == '-') {
        if (currentText.isNotEmpty) {
          operation.addNumber(int.tryParse(currentText) ?? 0);
          operation.addOperation(value);
          displayText += value;
          currentText = "";
        }

      } else if (value == '=') {
        if (currentText.isNotEmpty) {
          operation.addNumber(int.tryParse(currentText) ?? 0);
          operation.addOperation(value);
          int answer = operation.calculate();
          items.insert(0, Item(name: "$displayText = $answer"));
          currentText += answer.toString();
          displayText += "= $answer";
          operation.clear();
        }
        displayText = "";
        currentText = "";

      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      } else {
        currentText += value;
        displayText += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic Calculator!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
    ),
    body: Padding(padding: const EdgeInsets.all(12.0),
    child: Column(children: [
      TextField(readOnly: true, 
      controller: TextEditingController(text: displayText),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        
      ),
      ),
      const SizedBox(height: 20.0),
      CalculatorButtons(onButtonPressed: _buttonPressed,
      ),
      const SizedBox(height: 20.0),
      const Text("Calculation History", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index].name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,),
              ),
            );
          },
        ),
      ),
    ],
    ),
    ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Calculator',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 39, 127, 228),
        primary: const Color.fromARGB(255, 15, 37, 126),
        secondary: const Color.fromARGB(235, 126, 34, 246),
        tertiary: const Color.fromARGB(255, 131, 167, 252),
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.tektur(fontSize: 35, fontWeight: FontWeight.bold,),
        headlineMedium: GoogleFonts.rubikSprayPaint(fontSize: 25, fontWeight: FontWeight.bold,),
        headlineSmall: GoogleFonts.asap(fontSize: 15, fontWeight: FontWeight.bold,),
      ),
    ),
    home: const CalculatorApp(),
  ));
}
