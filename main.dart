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
    void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
//membuat layout pada halaman HpmePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); //widget menggunakan state MyAppState
    var pair = appState.current; //variable pair menyimpan kata y sedang tampil/aktif

    return Scaffold( //base (canvas) dari layout
      body: Center(
        child: Column( //di atas swcaffold ada body body nya diberi kolom
        mainAxisAlignment: MainAxisAlignment.center,
          children: [ //di dalam kolom diberi teks
            Text('A random idea:'),
            BigCard(pair: pair), //mengambil nilai dari variabel pair,
            //lalu diubah menjadi huruf kecil semua, dan ditampilkan sebagai BigCard
            SizedBox(height: 10)
            ElevatedButton( //membuat button timbul di dalam body
              onPressed: () { //fungsi y dieksekusi ketika button di tekan
                appState.getNext();  // ← This instead of print().
              },
              child: Text('Next'), //berikan teks 'Next' pada button (sebagai child)
            ),
          ],
        ),
      ),
    );
  }
}

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