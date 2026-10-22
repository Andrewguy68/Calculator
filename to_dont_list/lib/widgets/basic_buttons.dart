import 'package:flutter/material.dart';
typedef CalculatorCallback = Function(String value);
class CalculatorButtons extends StatelessWidget {
    final CalculatorCallback onButtonPressed;
    const CalculatorButtons({
        super.key,
        required this.onButtonPressed,
});

    Widget buildButton(BuildContext context, String buttonText){
        return SizedBox(
            width: 80,
            height: 60,
            child: ElevatedButton(
                onPressed: () => onButtonPressed(buttonText),
                child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                    ),
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            
            children: [
                buildButton(context, '1'),
                buildButton(context, '2'),
                buildButton(context, '3'),
                buildButton(context, '4'),
                buildButton(context, '5'),
                buildButton(context, '6'),
                buildButton(context, '7'),
                buildButton(context, '8'),
                buildButton(context, '9'),
                buildButton(context, '0'),
                buildButton(context, '+'),
                buildButton(context, '-'),
                buildButton(context, '='),
                buildButton(context, 'C'),
            ],
        );
    }
}