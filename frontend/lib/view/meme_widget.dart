import 'package:flutter/material.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/view/create_meme_widget.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:provider/provider.dart';

class MemeWidget extends StatefulWidget {
  final MemeModal meme;
  final int pos;

  const MemeWidget({Key key, this.meme, this.pos}) : super(key: key);

  @override
  _MemeWidgetState createState() => _MemeWidgetState();
}

class _MemeWidgetState extends State<MemeWidget> {
  MemeProvider _provider;
  bool _loading = false;
  MemeModal _meme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_provider == null) {
      _provider = Provider.of<MemeProvider>(context, listen: false);
      _meme = widget.meme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _loading
            ? Loader()
            : Column(
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
                            onTap: _update,
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

  void _update() async {
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
      setState(() {
        _loading = true;
      });

      final updated = res.copyWith(
        id: _meme.id,
        name: _meme.name,
        caption: res.caption == null ? _meme.caption : res.caption,
        url: res.url == null ? _meme.url : res.url,
      );
      if (await _provider.updateMeme(updated, widget.pos)) {
        _meme = updated;
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void _delete() async {
    setState(() {
      _loading = true;
    });
    await _provider.deleteMeme(_meme, widget.pos);
    setState(() {
      _loading = false;
    });
  }
}
