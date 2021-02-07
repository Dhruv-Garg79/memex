import 'package:frontend/model/meme_modal.dart';
import 'package:frontend/model/response.dart';
import 'package:frontend/utils/api_client.dart';
import 'package:frontend/utils/app_logger.dart';
import 'package:frontend/utils/global.dart';

class MemeApiProvider {
  Future<Response<List<MemeModal>>> fetchAllMemes() async {
    try {
      final path = "${Global.baseurl}/memes";
      final response = await ApiClient.getInstance().get(path);

      AppLogger.print(response.toString());
      if (response.statusCode == 200) {
        final List<MemeModal> list = [];
        (response.data as List).forEach((element) {
          list.add(MemeModal.fromMap(element));
        });

        return Response<List<MemeModal>>(list);
      } else {
        return Response.withError(response.data['error'].toString());
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      return Response.withError(e.toString());
    }
  }

  Future<Response<int>> createMeme(MemeModal meme) async {
    try {
      final path = "${Global.baseurl}/memes";
      final response = await ApiClient.getInstance().post(
        path,
        queryParameters: meme.toMap(),
      );

      if (response.statusCode == 200) {
        return Response(response.data['id']);
      } else {
        return Response.withError(response.data['error'].toString());
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      return Response.withError(e.toString());
    }
  }

  Future<Response<String>> updateMeme(MemeModal meme) async {
    try {
      final params = {};
      if (meme.caption != null) params['caption'] = meme.caption;
      if (meme.url != null) params['url'] = meme.url;

      final path = "${Global.baseurl}/memes/${meme.id}";
      final response = await ApiClient.getInstance().patch(
        path,
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        return Response(response.data['message']);
      } else {
        return Response.withError(response.data['error'].toString());
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      return Response.withError(e.toString());
    }
  }

  Future<Response<String>> deleteMeme(int id) async {
    try {
      final path = "${Global.baseurl}/memes/$id";
      final response = await ApiClient.getInstance().delete(path);

      if (response.statusCode == 200) {
        return Response(response.data['message']);
      } else {
        return Response.withError(response.data['error'].toString());
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      return Response.withError(e.toString());
    }
  }
}
