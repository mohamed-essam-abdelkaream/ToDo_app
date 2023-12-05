import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/sqldb.dart';
import 'package:todo_app/presentation/homePage.dart';
import 'package:todo_app/widgets.dart';

class EditNotes extends StatefulWidget {

  late final note;
  late final title;
  late final color;
  late final id;
  EditNotes({Key? key , this.note, this.title , this.color ,this.id}): super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

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
                      onPressed: () async {
                        int response = await sqlDb.updateData('''
                        UPDATE notes SET 
                        note="${note.text}" , 
                        title ="${title.text}" , 
                        color ="${color.text}"
                        WHERE id =${widget.id}
                        ''');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                        }
                      },
                      child: Text('Edit note'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
