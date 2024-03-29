import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './card_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
  ];
  var cardIndex = 0;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  var cardList = [
    CardItem('Personal', Icons.account_circle, 9, 0.83),
    CardItem('Work', Icons.work, 12, 0.24),
    CardItem('Home', Icons.home, 7, 0.32),
  ];

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ScrollController scrollController;
  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      appBar: AppBar(
        title: Text(
          'TODO',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 64.0,
                  vertical: 32.0,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 45.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                        child: Text(
                          'Hello, Masa.',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'Looks like feel good.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'You have 3 tasks to do today.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 64.0, vertical: 16.0),
                    child: Text(
                      formattedDate,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 350.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                width: 250.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            cardList[position].icon,
                                            color: appColors[position],
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Text(
                                              '${cardList[position].tasksRemaining} Tasks',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Text(
                                              '${cardList[position].title}',
                                              style: TextStyle(fontSize: 28.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: LinearProgressIndicator(
                                                value: cardList[position]
                                                    .taskCompletion),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          onHorizontalDragEnd: (details) {
                            animationController = AnimationController(
                              vsync: this,
                              duration: Duration(milliseconds: 500),
                            );
                            curvedAnimation = CurvedAnimation(
                              parent: animationController,
                              curve: Curves.fastOutSlowIn,
                            );
                            animationController.addListener(() {
                              setState(() {
                                currentColor =
                                    colorTween.evaluate(curvedAnimation);
                              });
                            });
                            if (details.velocity.pixelsPerSecond.dx > 0) {
                              if (cardIndex > 0) {
                                cardIndex--;
                                colorTween = ColorTween(
                                  begin: currentColor,
                                  end: appColors[cardIndex],
                                );
                              }
                            } else {
                              if (cardIndex < 2) {
                                cardIndex++;
                                colorTween = ColorTween(
                                  begin: currentColor,
                                  end: appColors[cardIndex],
                                );
                              }
                            }
                            setState(() {
                              scrollController.animateTo((cardIndex) * 256.0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            });
                            colorTween.animate(curvedAnimation);
                            animationController.forward();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}
