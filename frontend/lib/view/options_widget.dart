import 'package:flutter/material.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/utils/helper.dart';
import 'package:frontend/view/create_meme_widget.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:provider/provider.dart';

class OptionsWidget extends StatefulWidget {
  final MemeModal meme;
  final int pos;

  const OptionsWidget({Key key, this.meme, this.pos}) : super(key: key);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
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
    return _loading
        ? SizedBox(
            height: 24,
            width: 24,
            child: Loader(),
          )
        : Row(
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

      setState(() {
        _loading = true;
      });
      if (await _provider.updateMeme(updated, widget.pos)) {
        Helper.showToast("Updated successfully", true);
      } else {
        Helper.showToast("Update Failed", false);
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
    if (await _provider.deleteMeme(_meme, widget.pos)) {
      Helper.showToast("Deleted successfully", true);
    } else {
      Helper.showToast("Delete Failed", false);
    }
    setState(() {
      _loading = false;
    });
  }
}
