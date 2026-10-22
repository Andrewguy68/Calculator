// Data class to keep the operation name.
class Item {
  const Item({required this.name});
  final String name;
}

class Operation {
  final List<int> numbers = [];
  final List<String> operations = [];

  void addNumber(int number) {
    numbers.add(number);
  }

  void addOperation(String operation) {
    operations.add(operation);
  }
  int calculate() {
    if (numbers.isEmpty) {
      return 0;
    }

    int result = numbers[0];

    for (int i = 0; i < operations.length -1; i++) {
      String operation = operations[i];
      int nextNumber = numbers[i + 1];

      if (operation == '+') {
        result += nextNumber;
      } else if (operation == '-') {
        result -= nextNumber;
      }
    }

    return result;
  }
  void clear() {
    numbers.clear();
    operations.clear();
  }
}
