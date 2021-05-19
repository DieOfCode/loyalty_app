import 'package:loaylity_app/database/database.dart';
import 'package:loaylity_app/model/profile.dart';

class ProfileDao {
  final dbProvider = DatabaseProvider();

  Future<Profile> getProfileByLogin(String login) async {
    final db = await dbProvider.database;
    var result = await db
        .query(Profile.table, where: 'login LIKE ?', whereArgs: [login]);
    List<Profile> profiles = result.isNotEmpty
        ? result.map((profile) => Profile.fromMap(profile)).toList()
        : [];
    print(profiles);
    return profiles.last;
  }

  Future<Profile> getProfileById(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.query(Profile.table, where: 'id LIKE ?', whereArgs: [id]);
    List<Profile> profiles = result.isNotEmpty
        ? result.map((profile) => Profile.fromMap(profile)).toList()
        : [];
    print(profiles);
    return profiles.last;
  }

  Future<int> createProfile(Map<String, dynamic> preparedProfile) async {
    final db = await dbProvider.database;

    var result = db.insert(Profile.table, preparedProfile);
    return result;
  }

  Future<int> updateProfile(Profile profile) async {
    final db = await dbProvider.database;
    var result = await db.update(Profile.table, profile.toMap(),
        where: 'id = ?', whereArgs: [profile.id]);
    return result;
  }
}
