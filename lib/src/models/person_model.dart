import 'package:hive/hive.dart';

part 'person_model.g.dart';

@HiveType(typeId: 1)
class PersonModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  List<PersonModel> friends;

  PersonModel({required this.name, required this.age, required this.friends});

  factory PersonModel.empty() => PersonModel(name: '', age: 0, friends: []);
}
