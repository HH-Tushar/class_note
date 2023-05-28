import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../operations.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mykey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Subject"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  prefixIcon: (Icon(Icons.title)), //icon inside box
                  hintText: "Title",
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                 onChanged: (value) => ValueNotifier(mykey),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Note Must Have a Title";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(maxLines: 8,
                minLines: 5,
                textInputAction: TextInputAction.newline,
                controller: descriptionController,
                decoration: const InputDecoration(
                  prefixIcon: (Icon(Icons.description)), //icon inside box
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {

                    context.read<SubjectOperation>().addSubject(
                        titleController.text.toString(),
                        descriptionController.text.toString());
                    print(
                        "new length of main subject is :${context.read<SubjectOperation>().getSubject.length}");
                    titleController.dispose();
                    descriptionController.dispose();

                    Navigator.pop(context);

                 },
                child: const Text("Add Subject"))
          ],
        ),
      )),
    );
  }
}
