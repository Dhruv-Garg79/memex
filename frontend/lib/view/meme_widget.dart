import 'package:flutter/material.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/utils/helper.dart';
import 'package:frontend/view/create_meme_widget.dart';
import 'package:provider/provider.dart';

class MemeWidget extends StatelessWidget {
  final MemeModal meme;
  final int pos;

  MemeWidget({Key key, this.meme, this.pos}) : super(key: key);

  MemeProvider _provider;
  MemeModal _meme;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      _provider = Provider.of<MemeProvider>(context, listen: false);
      _meme = meme;
    }
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
                  _meme.name,
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onTap: () => _update(context),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: _delete,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              _meme.caption,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpeg",
                image: _meme.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _update(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final MemeModal res = await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: SizedBox(
          width: size.width * 0.8,
          child: CreateMemeWidget(
            update: true,
          ),
        ),
      ),
    );

    if (res != null) {
      final updated = res.copyWith(
        id: _meme.id,
        name: _meme.name,
        caption: res.caption == null ? _meme.caption : res.caption,
        url: res.url == null ? _meme.url : res.url,
      );

      if (await _provider.updateMeme(updated, pos)) {
        Helper.showToast("Updated successfully", true);
      } else {
        Helper.showToast("Update Failed", false);
      }
    }
  }

  void _delete() async {
    if (await _provider.deleteMeme(_meme, pos)) {
      Helper.showToast("Deleted successfully", true);
    } else {
      Helper.showToast("Delete Failed", false);
    }
  }
}
