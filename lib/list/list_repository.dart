import 'movielist_api_provider.dart';
import 'item_model.dart';
import 'activitylist_api_provider.dart';

class ListRepository {
  final movielistApiProvider =
      MovieListApiProvider("http://api.themoviedb.org");

  final activitylistApiProvider = ActivityListApiProvider(
      "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io");

  Future<ItemModel> fetchList() => movielistApiProvider.fetchList();

  Future<List<Activity>> retrieveActivities() =>
      activitylistApiProvider.retrieveActivities();
}
