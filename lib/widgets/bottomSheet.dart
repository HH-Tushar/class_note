import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../operations/operations.dart';
import '../ui/createNoteScreen.dart';
import 'confirmDelete.dart';

class Bottomsheet extends StatelessWidget {
  final String customId;
  final bool istopic;
  Bottomsheet({Key? key, required this.customId, required this.istopic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void action(String topicId){
      //deleting current topic
      Provider.of<TopicOperation>(context,
          listen: false)
          .deleteTopic(topicId);

    }
    return Container(
        height: 50,
        width: double.infinity,
        color: Colors.teal,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CreateNoteScreen(
                            isTopic: istopic,
                            topicId: customId,
                          )));
                },
                shape: const CircleBorder(),
                color: Colors.green,
                elevation: 10,
                minWidth: 25,
                height: 45,
                child: const Icon(Icons.edit),
              ),
              MaterialButton(
                onPressed: () async {
                  final bool confirmation = await showDialog(
                      context: context, builder: (_) => const ConfirmDelete());
                  // confirming deleting
                  if (confirmation) {
                    action(customId);

                  }
                },
                shape: const CircleBorder(),
                color: Colors.green,
                elevation: 10,
                minWidth: 45,
                height: 45,
                child: const Icon(Icons.delete_rounded),
              ),
            ],
          ),
        ));
  }
}
