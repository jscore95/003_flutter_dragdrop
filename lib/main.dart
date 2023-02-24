import 'package:flutter/material.dart';

void main() {
  // runApp(const MyAppStateless());
  // runApp(const MyAppStateful());
  runApp(const AppReorderable());
}

class MyAppStateless extends StatelessWidget {
  const MyAppStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drag and Drop Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Draggable<String>(
                data: "random data",

                // the thing that we're dragging (from source to destination)
                feedback: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue.withOpacity(0.5),
                  child: const Center(
                    child: Text('Dragging',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Colors.red)),
                  ),
                ),

                // source widget (which stays back) while we're dragging it
                childWhenDragging: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue.withOpacity(0.2),
                  child: const Center(
                    child: Text('Drag Me'),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: const Center(
                    child: Text('Drag Me'),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DragTarget(
                builder: (context, accepted, rejected) {
                  return Container(
                    width: 150,
                    height: 150,
                    color: accepted.isEmpty ? Colors.grey : Colors.green,
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //   color: Colors.black, // change the color here
                    //   width: 10, // set the width of the border
                    // )),
                    child: const Center(
                      child: Text('Drop Here'),
                    ),
                  );
                },
                onMove: (data) {
                  print("Entered");
                },
                onLeave: (data) {
                  print("Left");
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  print('Item dropped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({super.key});

  @override
  MyAppStatefulState createState() => MyAppStatefulState();
}

class MyAppStatefulState extends State<MyAppStateful> {
  List<Widget> droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drag and Drop Example'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable<Widget>(
                  data: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                    child: const Center(child: Text('Item 1')),
                  ),
                  feedback: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue.withOpacity(0.5),
                    child: const Center(child: Text('Item 1')),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: const Center(child: Text('Item 1')),
                  ),
                ),
                Draggable<Widget>(
                  data: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                    child: const Center(child: Text('Item 2')),
                  ),
                  feedback: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red.withOpacity(0.5),
                    child: const Center(child: Text('Item 2')),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: const Center(child: Text('Item 2')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DragTarget<Widget>(
              builder: (context, accepted, rejected) {
                return Container(
                  width: 300,
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: droppedItems.isEmpty
                        ? [const Text('Drop items here')]
                        : droppedItems,
                  ),
                );
              },
              onWillAccept: (Widget? data) {
                return true;
              },
              onAccept: (Widget data) {
                setState(() {
                  droppedItems.add(data);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppReorderable extends StatefulWidget {
  const AppReorderable({super.key});

  @override
  AppReorderableState createState() => AppReorderableState();
}

class AppReorderableState extends State<AppReorderable> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Reorderable List Drag and Drop'),
        ),
        body: ReorderableListView(
          children: [
            for (final item in items)
              ListTile(
                key: Key(item),
                title: Text(item),
                // leading: const Icon(Icons.drag_handle),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = items.removeAt(oldIndex);
              items.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
