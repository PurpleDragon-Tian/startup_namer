//导包
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/common_widget.dart';

//主方法，
// 由于方法体只有一行语句，所以使用简写方式,
// 组件对象通过调用器默认构造方法生成
void main() {
  runApp(new MaterialApp(
    title: "Hello Widgets",
    home: new MyScaffold(),
  ));
}

/**
 * 定义一个无状态的组件类，用于展示程序页面
 */
class MyApp extends StatelessWidget {
  //覆写父类build方法，生成自己的组件
  @override
  Widget build(BuildContext context) {
//    final englishWord = new WordPair.random();
    return new MaterialApp(
      home: new RandomWordsListView(),
      theme: new ThemeData(primaryColor: Colors.white),
      color: new Color(0xFFFF0000),
    );
  }
}

class RandomWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordState();
  }
}

class RandomWordState extends State<RandomWordsWidget> {
  @override
  Widget build(BuildContext context) {
    //随机生成单词对
    final wordPair = new WordPair.random();
    //返回文本对象
    return new Text(wordPair.asPascalCase);
  }
}

class RandomWordsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsListViewState();
  }
}

class RandomWordsListViewState extends State<RandomWordsListView> {
  //定义List，也就是数组
  final _suggestionPairs = <WordPair>[];

  //定义字体样式
  final _biggerFont = new TextStyle(fontSize: 18.0);

  //定义一个SET用于存储收藏的单词对
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome to flutter world'),
        //actions是个集合
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(icon: new Icon(Icons.add), onPressed: null)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    //push方法进行路由栈的压栈操作，要新页面的路由压入路由栈，pop方法是将当前路由从路由栈中弹出。该方法不必主动调用，只要添加返回键，系统会自动调用。
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      //builder是一个typedef 定义的WidgetBuilder类型的函数对象，该类型的函数返回值是Widget
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            //在每一列之前添加1个像素高的分割线
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestionPairs.length) {
            _suggestionPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestionPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
