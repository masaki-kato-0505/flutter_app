import 'package:flutter/material.dart';

// 最初に呼び出されるファンクション
void main() {
  runApp(const MyApp());
}

// メインのクラス
class MyApp extends StatelessWidget {
  // インスタンス生成時にコンストラクタを呼び出し変数を初期化
  // keyはWidgetを一意に識別するための変数として利用されるが、
  // TodoリストのようにWidgetを入れ替えたりするようなときは使うが、それ以外はほとんど使われない
  // superは親クラス（ここではStatelessクラス）のkeyを参照している。
  const MyApp({super.key});

  // MyAppにextendsでStatelessWidgetを継承させて、その性質をbuild()で上書きする
  // StatelessWidgetもクラスであり、buildメソッドを持ち、Widgetもしくはテキストを返す
  // build()メソッドを持つ、StatelessWidgetをMyAppクラスが継承し、
  // MyAppクラス内のbuild()メソッドは@overrideすることで再定義できる。
  // 親クラスであるStatelessWidgetで定義されているbuild()メソッドをMyAppクラスで再定義することができる
  @override
  Widget build(BuildContext context) {
    // マテリアルデザインを行うためのクラス（MaterialApp()）
    return MaterialApp(
      //デバックモードで実行する際に、画面右上にデバック中の表記を行うか否か
      debugShowCheckedModeBanner: false,
      //アプリケーション題名
      title: 'Flutter Demo',
      //テーマ（アプリケーションの背景色やレイアウトなど）
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ホームに表示したいWidgetを描画するクラスを指定する
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// StatefulWidgetは画面UIの一部が動的に変化する可能性がある場合に有用
// ユーザーから受け取った（ユーザーに入力された）情報を受けて、画面を再描画（リビルド）するWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // StatefulWidgetがcreateState()メソッドでStateを持つ状態に描画する
  // クラス名として、State型のMyHomePageという名称で_MyHomePageState()クラスをインスタンス化する。
  State<MyHomePage> createState() => _MyHomePageState();
}

// Stateクラスを継承する
// Stateクラスにはbuildメソッドを持っており、これによりWidgetの塊であるWidgetツリー（Scaffold以下）を返す
// StatefulWidgetとStateは1組になっており、Stateがいろんな情報を持ち、setState()でState自身の状態が変わったという通知を行い、
// StatefulWidgetに画面の再描画をするように依頼している。
// StatefulWidgetはあまり使わない
//   ◆離れたWidget間での状態変更を通知しにくい（StateクラスとStatefulWidgetクラスが対になって動作するため）
//   ◆パフォーマンスが下がることがある（状況によるが、いちいち全てのWidgetを再描画するため）
//   ◆メンテナンスしにくい（Widgetやロジックを全部Stateにつめこんでいるため）
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // クラス内で定義したメソッド
  // カウンターを1増やす
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // クラスで表示される画面のWidgetツリー一覧
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // アプリケーションバー（画面のヘッダー）
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // HTMLのbodyと概ね同じ
      body: Center(
        // ColumnはWidgetを縦に並べるもの
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              // $を付与することで文字列中に変数の埋め込みができる
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // 画面下部に設置可能なボタン
      floatingActionButton: FloatingActionButton(
        // ボタンクリック時に呼び出すメソッド
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
