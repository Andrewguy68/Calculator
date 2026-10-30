// Data class to keep the string and have an abbreviation function

import 'package:flutter/material.dart';

//tracks the different status of the books
enum BookStatus {unopened, started, finished}

extension BookStatusX on BookStatus {
  Color color(BuildContext context) {
    //Added calls to theme instead of hard coded colors. And changed this to add context
    switch (this) {
      case BookStatus.unopened:
        return Theme.of(context).colorScheme.primary;
      case BookStatus.started:
        return Theme.of(context).colorScheme.secondary;
      case BookStatus.finished:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

//cycles the status
  BookStatus get next {
    switch (this) {
      case BookStatus.unopened:
        return BookStatus.started;
      case BookStatus.started:
        return BookStatus.finished;
      case BookStatus.finished:
        return BookStatus.unopened;
    }
  }
}

class Books {
  const Books({required this.title, this.author = "", this.status = BookStatus.unopened});
  final String title;
  final String author;
  final BookStatus status;

  //retrieves book status
  String getStatus() {
    switch (status) {
      case BookStatus.unopened:
        return "new";
      case BookStatus.started:
        return "reading";
      case BookStatus.finished:
        return "read";
    }
  }

  //the function creates a new book since title and status and title are final
Books copyWith({String? title, String? author, BookStatus? status}) {
  String newTitle = this.title;
  if (title != null) {
    newTitle = title;
  }

  String newAuthor = this.author;
  if (author != null) {
    newAuthor = author;
  }

  BookStatus newStatus = this.status;
  if (status != null) {
    newStatus = status;
  }

  return Books(title: newTitle, author: newAuthor, status: newStatus);
}
  
}
