import 'package:flutter/material.dart';
import 'package:todo_app/data/sqldb.dart';
import 'package:todo_app/presentation/editNotes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();

  bool isLoading = true;

  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'notes'");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('AddNotes');
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(
              child: Text("is loading...."),
            )
          : Container(
              child: ListView(
                children: [
                  //MaterialButton(onPressed: ()async{
                  //await sqlDb.myDeleteDatabase();
                  //},
                  //child: Text('delete database'),
                  //),
                  ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (Context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${notes[i]['title']}"),
                          subtitle: Text("${notes[i]['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlDb.deleteData(
                                      "DELETE FROM notes WHERE id= ${notes[i]['id']}");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditNotes(
                                          color: notes[i]['color'],
                                          note: notes[i]['note'],
                                          title: notes[i]['title'],
                                          id: notes[i]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
