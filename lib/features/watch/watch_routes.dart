/// Watch route table. Deliberately separate from the phone router: the
/// wrist carries one flow (ask → matches → hand off), so none of the
/// shell tabs, the add sheet or the collection routes exist here.
abstract final class WatchRoutes {
  static const home = '/';
  static const listening = '/listening';
  static const results = '/results';
  static const item = '/item';

  static String itemPath(String id) => '$item/$id';
}
