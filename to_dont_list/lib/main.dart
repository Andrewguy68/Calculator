// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/pokemon.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

final ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green).copyWith(
    primary: const Color.fromARGB(255, 91, 230, 96),
    onPrimary: const Color.fromARGB(255, 36, 115, 38),
    secondary: const Color.fromARGB(255, 86, 174, 247),
    onSecondary: const Color.fromARGB(255, 25, 94, 150),
    tertiary: Colors.red,
    onTertiary: const Color.fromARGB(255, 136, 36, 29),
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    ),
  ),
);

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

// Pokemon Zones
class FireZone
 extends StatelessWidget{
  const FireZone
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      appBar: AppBar(
        title: const Text('Fire Zone'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      body: const Center(
        child: Text('Tap To Catch Fire Pokemon!')
      ),
    );

  }
}

class GrassZone
 extends StatelessWidget{
  const GrassZone
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(title: const Text('Grass Zone'), centerTitle: true,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),),
      body: const Center(
        child: Text('Tap To Catch Grass Pokemon!')
      ),
    );

  }
}

class WaterZone
 extends StatelessWidget{
  const WaterZone
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(title: const Text('Water Zone'), centerTitle: true,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),),
      body: const Center(
        child: Text('Tap To Catch Water Pokemon!')
      ),
    );

  }
}
// Pokemon Zones

class _ToDoListState extends State<ToDoList> {
  final List<Pokemon> items = [];
  final _itemSet = <Pokemon>{};

  @override
  void initState(){
    super.initState();
    _loadStarterPokemon();
  }

  void catchPokemon(String name){
    setState(() {
      //(i) = pokemon in list, i.name = pokemon name, name = catchPokemon(name)
      final item = items.firstWhere((i) => i.name == name);
      item.count++;
      _itemSet.add(item);
    });
  }

  void _loadStarterPokemon(){
    items.addAll([
      //Gen 1
      Pokemon(name: "Bulbasaur", type: "grass"),
      Pokemon(name: "Charmander", type: "fire"),
      Pokemon(name: "Squirtle", type: "water"),
      //Gen 2
      Pokemon(name: "Chikorita", type: "grass"),
      Pokemon(name: "Cyndaquil", type: "fire"),
      Pokemon(name: "Tododile", type: "water"),
      //Gen 3
      Pokemon(name: "Treecko", type: "grass"),
      Pokemon(name: "Torchic", type: "fire"),
      Pokemon(name: "Mudkip", type: "water"),
      //Might keep it small for the sake of not having to scroll so much
      /*//Gen 4
      Item(name: "Turtwig", type: "grass"),
      Item(name: "Chimchar", type: "fire"),
      Item(name: "Piplup", type: "water"),
      //Gen 5
      Item(name: "Snivy", type: "grass"),
      Item(name: "Tepig", type: "fire"),
      Item(name: "Oshawott", type: "water"),
      //Gen 6
      Item(name: "Chespin", type: "grass"),
      Item(name: "Fennekin", type: "fire"),
      Item(name: "Froakie", type: "water"),
      //Gen 7
      Item(name: "Rowlet", type: "grass"),
      Item(name: "Litten", type: "fire"),
      Item(name: "Popplio", type: "water"),
      //Gen 8
      Item(name: "Grookie", type: "grass"),
      Item(name: "Scorbunny", type: "fire"),
      Item(name: "Sobble", type: "water"),
      // Gen 9
      Item(name: "Spirigatito", type: "grass"),
      Item(name: "Fuecoco", type: "fire"),
      Item(name: "Quaxly", type: "water"),*/
    ]);
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return ToDoListItem(
              item: item,
              //Completed going to be repurposed as Caught or !Caught
              caught: _itemSet.contains(item),
            );
          }).toList(),  
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            //Fire Type Zone
            Align(
              alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FireZone
                    ()),
                    );
                  },
                  tooltip: 'Open Fire Zone',
                  backgroundColor: colors.tertiary,
                  foregroundColor: colors.onTertiary,
                  child: const Icon(Icons.local_fire_department),
                ),
              ),
            //Grass Type Zone
            Align(
              alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GrassZone
                    ()),
                    );
                  },
                  tooltip: 'Open Grass Zone',
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  child: const Icon(Icons.grass),
                ),
              ),
            //Water Type Zone
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WaterZone
                    ()),
                    );
                },
                tooltip: 'Open Water Zone',
                backgroundColor: colors.secondary,
                foregroundColor: colors.onSecondary,
                child: const Icon(Icons.waves),
              ),
            ),
          ],
        ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'To Do List',
    theme: theme,
    home: const ToDoList(),
  ));
}
