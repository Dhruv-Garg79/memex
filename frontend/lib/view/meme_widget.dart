import 'package:flutter/material.dart';
import 'package:frontend/model/meme_modal.dart';

class MemeWidget extends StatefulWidget {
  final MemeModal meme;
  final int pos;

  const MemeWidget({Key key, this.meme, this.pos}) : super(key: key);

  @override
  _MemeWidgetState createState() => _MemeWidgetState();
}

class _MemeWidgetState extends State<MemeWidget> {
  @override
  Widget build(BuildContext context) {
    final meme = widget.meme;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              meme.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 4),
            Text(
              meme.caption,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpeg",
                image: meme.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
