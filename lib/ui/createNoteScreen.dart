import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../operations/operations.dart';

class CreateNoteScreen extends StatefulWidget {
   String? subId;
  String? topicId;
  final bool isTopic;
  String  ?title;
  String ? description;
   CreateNoteScreen({Key? key,this.subId,this.topicId,required this.isTopic,this.title,this.description}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  late String? dummyTitle=widget.title ?? "";
  late String? dummydes=widget.title==null?"":widget.description;
  late TextEditingController titleController = TextEditingController(text: dummyTitle);
  late TextEditingController descriptionController = TextEditingController(text:dummydes);
@override
  void dispose() {
  titleController.dispose();
  descriptionController.dispose();
  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.subId==null && widget.isTopic==null)? const Text("Add New Subject"):
        (widget.subId!=null && widget.isTopic==null)?const Text("Edit Subject"):
        (widget.subId==null && widget.isTopic==true)? const Text("Create New Topic"):const Text("Edit Topic"),
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
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Note Must Have a Title";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 8,
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
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {

                    if(widget.subId==null && widget.isTopic==false){
                      context.read<SubjectOperation>().addSubject(
                        titleController.value.text.toString(),
                        descriptionController.value.text.toString());
                    }
                    else if(widget.subId!=null && widget.isTopic==false){
                      context.read<SubjectOperation>().editSubject(
                          widget.subId!,
                          titleController.value.text.toString(),
                          descriptionController.value.text.toString(),);
                    }
                    else if(widget.topicId==null && widget.isTopic==true){
                      context.read<TopicOperation>().addTopic(
                          widget.subId!,
                          titleController.value.text.toString(),
                          descriptionController.value.text.toString(),);
                    }
                    else if(widget.topicId!=null && widget.isTopic==true){
                      context.read<TopicOperation>().editTopic(
                        widget.topicId!,
                          titleController.value.text.toString(),
                          descriptionController.value.text.toString(),);
                    }
                    Navigator.pop(context);
                 },
                child: const Text("Add Subject"))
          ],
        ),
      )),
    );
  }
}
