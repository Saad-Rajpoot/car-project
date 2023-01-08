import 'package:car_project/Constants/bindings.dart';
import 'package:car_project/Database/appdatabase.dart';
import 'package:car_project/Model/user_model.dart';
import 'package:car_project/Screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  /// store name
  static const String folderName = "Users";

  /// A Store with int keys and Map<String, dynamic> values.
  /// This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _userFolder = intMapStoreFactory.store(folderName);

  storeUserInfo() async {
    int user = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('User', user);
  }

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future addUser(UserModel userModel) async {
    /// query for find data
    final finder = Finder(
        filter: Filter.matches("email", userModel.email!),
        sortOrders: [SortOrder('email')]);

    /// actual find function who finds the data
    final recordSnapshots = await _userFolder.find(
      await _db,
      finder: finder,
    );

    /// data check
    if(recordSnapshots.isEmpty) {
      ///if no records found
      /// add data to database
      await _userFolder.add(await _db, userModel.toJson());
      /// store userdata locally
      storeUserInfo();
      /// delay some time and then navigate to home screen
      Future.delayed(Duration(seconds: 5), (){
        Get.to(()=> HomeScreen(), binding: HomeBinding());
      });
    } else {
      ///if data already exist
      Get.snackbar("Error", "Data Already Exist");
    }
  }

  Future loginUser(String email) async{
    final finder = Finder(
        filter: Filter.matches("email", email),
        sortOrders: [SortOrder('email')]);
    final recordSnapshots = await _userFolder.find(
      await _db,
      finder: finder,
    );
    if(recordSnapshots != []) {
      /// if user exists
      storeUserInfo();
      Future.delayed(Duration(seconds: 3), (){
        Get.to(()=> HomeScreen(), binding: HomeBinding());
      });
    } else {
      /// if user not registered
      Get.snackbar("Error", "User not registered");
    }

  }
}