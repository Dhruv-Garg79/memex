import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';

class CreateMemeWidget extends StatefulWidget {
  @override
  _CreateMemeWidgetState createState() => _CreateMemeWidgetState();
}

class _CreateMemeWidgetState extends State<CreateMemeWidget> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _url = TextEditingController();
  final _caption = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? Loader()
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Creator Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      controller: _name,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Caption',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Caption is required";
                        }
                        return null;
                      },
                      controller: _caption,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Meme Image Url',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Url is required";
                        }
                        if (!Uri.parse(value).isAbsolute) return "Invalid URL";
                        return null;
                      },
                      controller: _url,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text(
                            'Submit Meme',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: _submit,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final meme = MemeModal(
      name: _name.text,
      caption: _caption.text,
      url: _url.text,
    );

    setState(() {
      _loading = true;
    });
    final res = await Provider.of<MemeProvider>(context, listen: false)
        .createMeme(meme);

    Fluttertoast.showToast(
      msg: res ? "Meme added successfully" : "Meme not added",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: res ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _url.dispose();
    _caption.dispose();
  }
}
