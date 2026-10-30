import 'package:flutter/material.dart';

//books have title and (optionally) author
typedef BookListAddedCallback = Function(
    String title, String author, TextEditingController titleController, TextEditingController authorController);

class BookDialog extends StatefulWidget {
  const BookDialog({
    super.key,
    required this.onListAdded,
  });

  final BookListAddedCallback onListAdded;

  @override
  State<BookDialog> createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  String titleText = "";
  String authorText = "";

  @override
  //moved the buttons here to allow for context. And added calls to text and color theme
  Widget build(BuildContext context) {
    final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
    final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );

    return AlertDialog(
      title: const Text('Book To Add'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
        onChanged: (value) {
          setState(() {
            titleText = value;
          });
        },
        controller: _titleController,
        decoration: const InputDecoration(hintText: "Book title"),
      ),
          TextField(
            onChanged: (value) {
              setState(() {
                authorText = value;
              });
            },
            controller: _authorController,
            decoration: const InputDecoration(hintText: "Author name"),
          )
        ],
      ),
      
      actions: <Widget>[
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _titleController,
          builder: (context, value, child) {
            return ElevatedButton(
            key: const Key("OKButton"),
            style: yesStyle,
            onPressed: value.text.isNotEmpty
            ? () {
              setState(() {
                widget.onListAdded(titleText, authorText, _titleController, _authorController);
                Navigator.pop(context);
              });
          }
        : null,
        child: const Text('OK'),
        );
      },
    ),
        
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
