import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/sqldb.dart';
import 'package:todo_app/widgets.dart';

class AddNotes extends StatefulWidget {

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: note,
                        decoration: InputDecoration(hintText: "note"),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(hintText: "title"),
                      ),
                      TextFormField(
                        controller: color,
                        decoration: InputDecoration(hintText: "color"),
                      ),
                      defaultSizedBox(),
                      MaterialButton(
                          child: Text('Add'),
                          onPressed: () async {
                            int response = await sqlDb.insertData('''
                        INSERT INTO notes(`note` , `title` , `color`)
                        VALUES("${note.text}", "${title.text}","${color.text}")
                        ''');
                            if(response >0){
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
