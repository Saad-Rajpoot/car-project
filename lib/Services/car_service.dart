import 'package:car_project/Constants/bindings.dart';
import 'package:car_project/Controllers/car_controller.dart';
import 'package:car_project/Database/appdatabase.dart';
import 'package:car_project/Model/car_model.dart';
import 'package:car_project/Model/user_model.dart';
import 'package:car_project/Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';


class CarService {
  /// store name
  static const String CAR_STORE_NAME = 'Cars';
  /// A Store with int keys and Map<String, dynamic> values.
  /// This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _carStore = intMapStoreFactory.store(CAR_STORE_NAME);

  /// Private getter to shorten the amount of code needed to get the
  /// singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(CarModel carModel) async {
    /// add data into database
    await _carStore.add(await _db, carModel.toMap());
  }

  Future update(CarModel carModel, int id) async {
    /// update data into database
    await _carStore.record(id).update(await _db, carModel.toMap());
  }

  Future delete(CarModel carModel) async {
    /// delete data into database
    final finder = Finder(filter: Filter.byKey(carModel.id));
    await _carStore.delete(
      await _db,
      finder: finder,
    );
  }

   Future<List<CarModel>> getAllSortedByName() async {
    /// Finder object can also sort Database with descending order
     /// its a query
    final finder = Finder(sortOrders: [
      SortOrder('id', false),
    ],
    );

    /// actual find function
    final recordSnapshots = await _carStore.find(
      await _db,
      finder: finder,
    );

    /// Making a List<CarModel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final car = CarModel.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      car.id = snapshot.key;
      return car;
    }).toList();
  }

}

