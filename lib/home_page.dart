import 'package:flutter/material.dart';

import 'package:fluttersliverhero/orden_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<OrderItem> _items = [
    OrderItem(1, 'Mixed Grill', 'Platter', 1, 30.0, 'images/mixedgrill.jpg'),
    OrderItem(2, 'Grilled Chicken', 'Sandwich', 2, 10.0, 'images/chickensandwich.jpg'),
    OrderItem(3, 'Fresh orange Juice', 'Drink', 3, 8.0, 'images/orangejuice.jpg'),
    OrderItem(4, 'Fresh Apple Juice', 'Drink', 1, 8.0, 'images/applejuice.jpg'),
  ];
  static final _boldStyle = TextStyle(fontWeight: FontWeight.bold);
  static final _greyStyle = TextStyle(color: Colors.grey);
  final _ddValues = <int>[1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Resumen de ordenes'),
              background: Image.asset('images/restaurant.jpg'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            sliver: SliverFixedExtentList(
              itemExtent: 172.0,
              delegate: SliverChildBuilderDelegate(
                (builder, index) {
                  return _buildListItem(_items[index]);
                },
                childCount: _items.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(OrderItem item) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Flexible(child: _imagesItem(item), flex: 1),
          Flexible(child: _buildImage(item), flex: 1),
          Flexible(child: _buildColumn2(item), flex: 3),
        ],
      ),
    );
  }

  Widget _imagesItem(OrderItem item) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
      child: InkWell(
        child: Hero(tag: item.id, child: Image(image: AssetImage(item.icon))),
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                content: Hero(
                  tag: item.id,
                  child: InkWell(
                    child: Image(image: AssetImage(item.icon)),
                    onTap: ()=>Navigator.pop(context),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildImage(OrderItem item) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
      child: InkWell(
        child: Hero(
          tag: item.id,
          child: Image.asset(item.icon, width: 100.0, height: 100.0, fit: BoxFit.cover),
        ),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) {
                return Material(
                  color: Colors.black38,
                  child: Container(
                    padding: EdgeInsets.all(30.0),
                    child: InkWell(
                      child: Hero(
                        tag: item.id,
                        child: Image.asset(
                          item.icon,
                          width: 200.0,
                          height: 150.0,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildColumn2(OrderItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: Text(item.item, style: _boldStyle),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(item.category),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Cantidad', style: _greyStyle),
              SizedBox(width: 20.0),
              DropdownButton(
                items: _ddValues
                    .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                value: item.qty,
                onChanged: (int newVal) {
                  setState(() {
                    item.qty = newVal;
                  });
                },
              ),
            ],
          ),
        ),
        _buildBottomRow(item.price, item.qty),
      ],
    );
  }

  Widget _buildBottomRow(double price, int qty) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('Precio', style: _greyStyle),
          ),
          SizedBox(width: 5.0),
          Flexible(
            flex: 1,
            child: Text(price.toStringAsPrecision(2), style: _boldStyle),
          ),
          Flexible(
            flex: 1,
            child: Text('Total', style: _greyStyle),
          ),
          SizedBox(width: 5.0),
          Flexible(
            flex: 1,
            child: Text((qty * price).toString(), style: _boldStyle),
          ),
        ],
      ),
    );
  }
}
