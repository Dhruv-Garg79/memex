import 'package:flutter/material.dart';
import 'package:frontend/app_theme.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/model/view_state.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/utils/global.dart';
import 'package:frontend/view/create_meme_widget.dart';
import 'package:frontend/view/meme_widget.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:provider/provider.dart';

class MemeScreen extends StatefulWidget {
  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  bool _first = true;
  MemeProvider _provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_first) {
      _provider = Provider.of<MemeProvider>(context);
      _provider.fetchAllMemes();
      _first = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Consumer<MemeProvider>(
          builder: (context, value, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: child,
                ),
                if (value.state == ViewState.Idle ||
                    value.state == ViewState.Loading)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Loader(),
                    ),
                  ),
                if (value.memes.isNotEmpty) _buildMemesGrid(value.memes),
              ],
            );
          },
          child: _buildHeader(),
        ),
      ),
    );
  }

  void _showCreateMemeDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: CreateMemeWidget(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          Global.appName,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Post your memes and view what others post.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              child: Text(
                'Create Meme',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                _showCreateMemeDialog();
              },
              color: AppTheme.primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildMemesGrid(List<MemeModal> memes) {
    final width = MediaQuery.of(context).size.width;
    final widthOfIndividualCard = 330;
    final crossAxisCount = width ~/ widthOfIndividualCard;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.2,
        crossAxisCount: crossAxisCount == 0 ? 1 : crossAxisCount,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return MemeWidget(
            meme: memes[index],
            pos: index,
          );
        },
        childCount: memes.length,
      ),
    );
  }
}
