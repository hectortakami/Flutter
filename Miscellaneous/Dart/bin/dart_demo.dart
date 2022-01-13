import 'dart:convert';

// ****************************************************************************

void helloWorld() {
  String phrase = 'Hello World!';
  for (int i = 0; i < phrase.length; i++) {
    print(phrase[i]);
  }
}

// ****************************************************************************

void reverseList(List<int> list) {
  print(list.reversed.toList());
}

// ****************************************************************************

class Hero {
  String name;
  String alias;
  String power;

  Hero(this.name, this.alias, {this.power = 'fly'});

  String fight() => 'can $power!';

  @override
  String toString() => '$name is $alias';
}

void processJSON() {
  final rawJSON =
      '[{"name": "Tony Stark", "alias": "Ironman"}, {"name": "Peter Parker", "alias": "Spiderman", "power": "shoot webs"}]';
  List parsedJSON = json.decode(rawJSON);
  List<Hero> heroList = [];
  for (var item in parsedJSON) {
    Hero newHero = Hero(item['name'], item['alias']);
    if (item['power'] != Null && item['power'] is String) {
      newHero.power = item['power'];
    }
    heroList.add(newHero);
    print('$newHero and ' + newHero.fight());
  }
}

// ****************************************************************************

void main() {
  helloWorld();
  reverseList([1, 2, 3]);
  processJSON();
}
