import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test_coding_scbd/movie_model.dart';
import 'package:test_coding_scbd/utils.dart';

class MovieController extends GetxController {
  var movies = <MovieModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var response = await Dio().get(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZjY0ZjkyMzQ3MGMyODA1OWE5OTUzYjM2ZWEzYzlmZSIsIm5iZiI6MTcxOTM2OTUxNy40NTA4MzMsInN1YiI6IjY2NmNmNDdmZjUyYzE3YTNkMjk5OTE1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GEpGSY1XrpbSfIZbyBui_cffKOiIn4m8eqUPoCv4y_4'),
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.data['results'] as List;
        movies.value =
            jsonResponse.map((movie) => MovieModel.fromJson(movie)).toList();
      }
    } finally {
      isLoading(false);
    }
  }
}
