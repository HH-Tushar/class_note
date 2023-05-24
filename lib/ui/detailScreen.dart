import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../operations.dart';

class DetailsScreen extends StatefulWidget {
  final curindex;
  final String title;
  const DetailsScreen({Key? key, required this.curindex, required this.title}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text(widget.title),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<SubjectOperation>().addTopic(widget.curindex, "dj");
            //print("length of topics is ${context.read<SubjectOperation>().getTopics.length}");
          },
          child: const Icon(Icons.add_chart_sharp),
        ),
        body: Consumer<SubjectOperation>(
          builder: (context, subject, child) => ListView.builder(
              itemCount: subject.getSubject[widget.curindex].topics?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    isThreeLine: true,
                    minVerticalPadding: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    tileColor: Colors.black12,
                    title: Text(
                      subject.getSubject[widget.curindex].topics![index].title,
                    ),
                    subtitle: Text(
                        "${subject.getSubject[widget.curindex].topics![index].description}"),
                  ),
                );
              }),
        ));
  }
}
