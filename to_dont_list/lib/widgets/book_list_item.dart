import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/books.dart';

typedef BookStatusChangedCallback = Function(Books book, BookStatus newStatus);
typedef BookRemovedCallback = Function(Books book);

class BookListItem extends StatelessWidget {
  BookListItem(
      {required this.book,
      required this.onStatusChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(book));

  final Books book;
  final BookStatusChangedCallback onStatusChanged;
  final BookRemovedCallback onDeleteItem;

  TextStyle? _getTextStyle(BuildContext context) {
    if (book.status != BookStatus.finished) return null;
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: Theme.of(context).colorScheme.surface,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onStatusChanged(book, book.status.next);
      },
      onLongPress: (){
        onDeleteItem(book);
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: book.status.color(context),
        child: Text(book.getStatus()),
      ),
      title: Text(
        book.title,
        style: _getTextStyle(context),
      ),
      subtitle: book.author.isNotEmpty ? Text(book.author) : null,
    );
  }
}
