import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
//    title: 'Material Widget',
//    home: new TutorialHome(),
    title: "购物",
    home: new ShoppingList(products: <Product>[
      new Product(name: "苹果"),
      new Product(name: "西瓜"),
      new Product(name: "鸭梨"),
      new Product(name: "火龙果"),
      new Product(name: "香蕉"),
      new Product(name: "葡萄"),
//      new Product(name: "草莓"),
//      new Product(name: "榴莲"),
//      new Product(name: "橘子"),
    ]),
  ));
}

/**
 * 定义商品类
 */
class Product {
  String name;

  Product({this.name});
}

/**
 * 函数对象
 */
typedef CartChangedCallback = void Function(Product product, bool inCart);

/**
 * 定义商品列表的item, 是无状态widget
 * ":"语法是因为父类StatelessWidget没有默认的无参构造函数，只有一个有参构造函数“ StatelessWidget({ Key key })”，
 * 所以他的子类也必须不能有默认的无参构造函数，如何才能让子类没有默认的无参构造函数呢，那就是显示的声明一个有参数的构造函数，
 * 光是声明一个有参数构造函数还不行，还得调用一下父类的构造函数，如果父类有多个构造函数，则选取其中一个调用，这里只能调用” StatelessWidget({ Key key })“
 * 而且，如果子类不是一个抽象类(abstract)，则该构造方法还必须得有方法体，也就是在调用父类有参数构造函数之前还必须得未子类中的某个属性显式赋值，不可以通过this.field的形式进行赋值。
 */
class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  /**
   * 是否添加进了购物车
   */
  final bool inCart;

  /**
   * 商品model
   */
  final Product product;

  /**
   * item点击回调，相当于Android中的ClickListener
   */
  final CartChangedCallback onCartChanged;

  /**
   * 根据是否加入购物车来返回不同的颜色，用于展示圆形背景色
   */
  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  /**
   * 根据是否加入购物车来返回不同的文本style，用于区别展示
   */
  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return new TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  /**
   * 构建item
   */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

/**
 * 商品列表组件
 */
class ShoppingList extends StatefulWidget {
  /**
   * 定义productList，相当于Android中Adapter中的数据集合
   */
  final List<Product> products;

  @override
  _ShoppingListState createState() {
    // TODO: implement createState
    return new _ShoppingListState();
  }

  /**
   * 构造函数传入商品列表
   */
  ShoppingList({Key key, this.products}) : super(key: key);
}

/**
 *
 *
 *
 */
class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //标题栏
      appBar: new AppBar(
        title: new Text('Shopping List'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.menu), onPressed: null)
        ],
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map<Widget>((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }

  void _handleCartChanged(Product product, bool inCart) {
    //该方法用于更新ui，根据状态变化进行view的差异重绘
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }
}
