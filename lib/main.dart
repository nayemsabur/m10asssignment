import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<ListItem> items = [];

  void _addNewItem() {
    setState(() {
      items.insert(
        0,
        ListItem(
          title: _titleController.text,
          subtitle: _descriptionController.text,
        ),
      );
    });
    _titleController.clear();
    _descriptionController.clear();
  }

  void _editItem(int index, String newTitle, String newDescription) {
    setState(() {
      items[index] = ListItem(title: newTitle, subtitle: newDescription);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _showEditBottomSheet(int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: TextEditingController(text: items[index].title),
                  onChanged: (value) {
                    setState(() {
                      items[index].title = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Enter title'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: items[index].subtitle),
                  onChanged: (value) {
                    setState(() {
                      items[index].subtitle = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Enter description'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _editItem(index, items[index].title, items[index].subtitle);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Tile Demo')),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Enter title'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Enter description'),
                ),
              ),
              ElevatedButton(
                child: Text("Add"),
                onPressed: _addNewItem,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].subtitle),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Alart"),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showEditBottomSheet(index);
                                },
                                child: Text('Edit'),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteItem(index);
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),

                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem {
  String title;
  String subtitle;

  ListItem({required this.title, required this.subtitle});
}
