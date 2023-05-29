import 'package:flutter/material.dart';

class TopicDetailsScreen extends StatelessWidget {
  final String topicTitle;
  final String topicDetails;
  const TopicDetailsScreen({Key? key, required this.topicTitle, required this.topicDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topicTitle),
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child: Text(topicDetails,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),),
    );
  }
}
