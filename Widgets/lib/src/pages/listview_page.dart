import 'package:flutter/material.dart';

import 'dart:async';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  ScrollController _scrollController = new ScrollController();

  List<int> indexList = [];
  int lastItem = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _addImages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scroll List'),
        ),
        body: Stack(
          children: <Widget>[createListBuilder(), createLoader()],
        ));
  }

  Widget createListBuilder() {
    return RefreshIndicator(
      onRefresh: loadFistPage,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: indexList.length,
        itemBuilder: (BuildContext context, int index) {
          final imageSelected = indexList[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            child: FadeInImage(
              image: NetworkImage(
                  'https://picsum.photos/500/300/?random=$imageSelected'),
              placeholder: AssetImage('assets/jar-loader.gif'),
              fit: BoxFit.cover,
              height: 250.0,
            ),
          );
        },
      ),
    );
  }

  Future<Null> loadFistPage() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      indexList.clear();
      lastItem++;
      _addImages();
    });

    return Future.delayed(duration);
  }

  void _addImages() {
    for (var i = 1; i < 10; i++) {
      lastItem++;
      indexList.add(lastItem);
    }

    setState(() {});
  }

  Future fetchData() async {
    isLoading = true;
    setState(() {});
    // Simulates an API delayed response
    final duration = new Duration(seconds: 2);
    return new Timer(duration, () {
      isLoading = false;

      _scrollController.animateTo(_scrollController.position.pixels + 100,
          curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));

      _addImages();
    });
  }

  Widget createLoader() {
    if (isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          ),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }
}
