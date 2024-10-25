//memasukkan package y dibutuhkan oleh apluikasi
import 'package:english_words/english_words.dart'; //paket b inggris
import 'package:flutter/material.dart'; //paket untuk tampilan UI
import 'package:provider/provider.dart'; //paket untuk interaksi aplikasi

void main() {
  runApp(MyApp());
}
//membuat abstrak aplikasi dari statlesswidget (templete aplikasi), aplikasi bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //menunjukkan bahwa aplikasi ini tetap tidak berubah setelah di build

  @override //menganti nilai lama y sudah ada di template dengan nilai nilai y baru (replace / overwrite)
  Widget build(BuildContext context) {
    //fungsi y membangun UI (mengatur posisi widget, dst)
    //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi semua y terjadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), //membuat satu state bernama MyAppState
      child: MaterialApp( //pada state ini menggunakan style desain material UI
        title: 'Namer App', //diberi judul Namer App
        theme: ThemeData( //data tema aplikasi diberi warna deepOrange
          useMaterial3: true, //versi materialUI dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 111, 250, 255)),
        ),
        home: MyHomePage(), //nama halaman "MyHomePage" y menggunakan state "MyAppState"
      ),
    );
  }
}
//mendefinisikan MyAppState
class MyAppState extends ChangeNotifier {
  //state MyAppState diidi dgn 2 kata random y digabung. kata kata random tersebut disimpan di variable WordPair
var current = WordPair.random();
var favorites = <WordPair>[];
var selectedIndex = 0;
var selectedIndexInAnotherWidget = 0;
var indexInYet AnotherWidget = 42;
var optionASelected = false;
var optionBSelected = false;
var loadingFromNetwork = false;
  var current = WordPair.random();
    void getNext() {
    current = WordPair.random();
    notifyListeners();
  } 
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
//membuat layout pada halaman HpmePage
// ...

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                print('selected: $value');
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget { //widget BigCard
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        )
      ),
    );
  }
}