import 'package:loaylity_app/dao/profile_dao.dart';
import 'package:loaylity_app/model/profile.dart';

class ProfileRepository {
  final profileDao = ProfileDao();

  Future createProfile(Profile profile) =>
      profileDao.createProfile(profile.toMap());
  Future getProfileByLogin(String login) => profileDao.getProfileByLogin(login);
  Future getProfileById(int id) => profileDao.getProfileById(id);
  Future updateProfile(Profile profile) => profileDao.updateProfile(profile);
}
