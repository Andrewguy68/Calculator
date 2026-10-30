// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/books.dart';
import 'package:to_dont_list/widgets/book_list_item.dart';
import 'package:to_dont_list/widgets/book_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final List<Books> books = [const Books(title: "add more books")];
  void _handleListChanged(Books book, BookStatus newStatus) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      final index = books.indexOf(book);
      books[index] = book.copyWith(status: newStatus);
    });
  }

  void _handleDeleteItem(Books book) {
    setState(() {
      print("Deleting item");
      books.remove(book);
    });
  }

  void _handleNewBook(String title, String author, TextEditingController textController, TextEditingController authorController) {
    setState(() {
      print("Adding new item");
    //bug fix: change itemText to a string var not literal string
    //remove const so it can change
      books.insert(0, Books(title: title, author: author));
      textController.clear();
      authorController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Book List',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
      ),

        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: books.map((book) {
            return BookListItem(
              book: book,
              onStatusChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        //changed color of the action button on the bottom.
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return BookDialog(onListAdded: _handleNewBook);
                  });
            },
            child: const Icon(Icons.add)));
  }
}
//added color and text themes
void main() {
  runApp(MaterialApp(

      title: 'Book List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: const Color.fromARGB(255, 97, 153, 217),
          secondary: const Color.fromARGB(255, 115, 209, 118),
          tertiary: const Color.fromARGB(255, 210, 28, 70),
          surface: const Color.fromARGB(255, 255, 213, 175),
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.ebGaramond(fontSize: 40, fontWeight: FontWeight.bold,),
          headlineMedium: GoogleFonts.ebGaramond(fontSize: 30, fontWeight: FontWeight.bold,),
          headlineSmall: GoogleFonts.ebGaramond(fontSize: 20, fontWeight: FontWeight.normal,),
        ),
      ),
      home: const BookList(),
    ));
}
