import 'package:flutter/material.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/view/options_widget.dart';

class MemeWidget extends StatelessWidget {
  final MemeModal meme;
  final int pos;

  const MemeWidget({Key key, this.meme, this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meme.name,
                  style: TextStyle(fontSize: 18),
                ),
                OptionsWidget(
                  meme: meme,
                  pos: pos,
                ),
              ],
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
