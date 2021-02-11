import 'package:flutter/widgets.dart';
import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/model/view_state.dart';
import 'package:frontend/resource/meme_api_provider.dart';

class MemeProvider extends ChangeNotifier {
  final apiProvider = MemeApiProvider();
  final List<MemeModal> _memes = [];

  ViewState _state = ViewState.Idle;

  List<MemeModal> get memes => [..._memes];
  ViewState get state => _state;

  Future fetchAllMemes() async {
    final res = await apiProvider.fetchAllMemes();
    if (res.error.isNotEmpty) {
      _changeState(ViewState.Error);
    } else {
      _memes.addAll(res.modal);
      _changeState(ViewState.Done);
    }
  }

  Future<bool> createMeme(MemeModal meme) async {
    final res = await apiProvider.createMeme(meme);
    if (res.error.isNotEmpty) {
      return false;
    } else {
      _memes.insert(0, meme.copyWith(id: res.modal));
      notifyListeners();
      return true;
    }
  }

  Future<bool> updateMeme(MemeModal meme, int pos) async {
    final res = await apiProvider.updateMeme(meme);
    if (res.error.isNotEmpty) {
      return false;
    } else {
      final original = _memes[pos];
      _memes[pos] = original.copyWith(
        caption: meme.caption ?? original.caption,
        url: meme.url ?? original.url,
      );
      notifyListeners();
      return true;
    }
  }

  Future<bool> deleteMeme(MemeModal meme, int pos) async {
    final res = await apiProvider.deleteMeme(meme.id);
    if (res.error.isNotEmpty) {
      return false;
    } else {
      _memes.removeAt(pos);
      notifyListeners();
      return true;
    }
  }

  void _changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
