import 'dart:io';
import 'dart:convert';
import 'package:justice_complaints/model/communities.module.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/districts.module.dart';
import '../../model/governorates.module.dart';
import '../../model/subdistricts.module.dart';

Future<String> getgovernoratesFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/governoratesFile.json';
}

Future<void> saveGovernoratesToFile(List<GovernoratesModel> data) async {
  try {
    final file = File(await getgovernoratesFilePath());
    String jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
    print("Data saved to file Governorates.");
  } catch (e) {
    print("Error saving data Governorates: $e");
  }
}

Future<List<GovernoratesModel>> loadGovernoratesFromFile() async {
  try {
    final file = File(await getgovernoratesFilePath());
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonData);
      print("Data loaded from file Governorates.");
      return jsonList.map((e) => GovernoratesModel.fromJson(e)).toList();
    } else {
      print("File Governorates not found.");
      return [];
    }
  } catch (e) {
    print("Error loading data Governorates: $e");
    return [];
  }
}

Future<void> deleteGovernoratesFile() async {
  final file = File(await getgovernoratesFilePath());
  if (await file.exists()) {
    await file.delete();
    print("Governorates file deleted.");
  }
}

//////////////////////
Future<String> getDistrictsFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/districtsFile.json';
}

Future<void> saveDistrictsToFile(List<DistrictsModel> data) async {
  try {
    final file = File(await getDistrictsFilePath());
    String jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
    print("Data saved to file Districts.");
  } catch (e) {
    print("Error saving data Districts: $e");
  }
}

Future<List<DistrictsModel>> loadDistrictsFromFile() async {
  try {
    final file = File(await getDistrictsFilePath());
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonData);
      print("Data loaded from file Districts.");
      return jsonList.map((e) => DistrictsModel.fromJson(e)).toList();
    } else {
      print("File Districts not found.");
      return [];
    }
  } catch (e) {
    print("Error loading data Districts: $e");
    return [];
  }
}

Future<void> deleteDistrictsFile() async {
  final file = File(await getDistrictsFilePath());
  if (await file.exists()) {
    await file.delete();
    print("Districts file deleted.");
  }
}
//////////////////////
Future<String> getSubDistrictsFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/subDistrictsFile.json';
}

Future<void> saveSubDistrictsToFile(List<SubDistrictsModel> data) async {
  try {
    final file = File(await getSubDistrictsFilePath());
    String jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
    print("Data saved to file SubDistricts.");
  } catch (e) {
    print("Error saving data SubDistricts: $e");
  }
}

Future<List<SubDistrictsModel>> loadSubDistrictsFromFile() async {
  try {
    final file = File(await getSubDistrictsFilePath());
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonData);
      print("Data loaded from file SubDistricts.");
      return jsonList.map((e) => SubDistrictsModel.fromJson(e)).toList();
    } else {
      print("File SubDistricts not found.");
      return [];
    }
  } catch (e) {
    print("Error loading data SubDistricts: $e");
    return [];
  }
}

Future<void> deleteSubDistrictsFile() async {
  final file = File(await getSubDistrictsFilePath());
  if (await file.exists()) {
    await file.delete();
    print("Districts file deleted.");
  }
}

//////////////////////
Future<String> getCommunityFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/communityFile.json';
}

Future<void> saveCommunityToFile(List<CommunitiesModel> data) async {
  try {
    final file = File(await getCommunityFilePath());
    String jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
    print("Data saved to file Community.");
  } catch (e) {
    print("Error saving data Community: $e");
  }
}

Future<List<CommunitiesModel>> loadCommunityFromFile() async {
  try {
    final file = File(await getCommunityFilePath());
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonData);
      print("Data loaded from file Community.");
      return jsonList.map((e) => CommunitiesModel.fromJson(e)).toList();
    } else {
      print("File Community not found.");
      return [];
    }
  } catch (e) {
    print("Error loading data Community: $e");
    return [];
  }
}

Future<void> deleteCommunityFile() async {
  final file = File(await getCommunityFilePath());
  if (await file.exists()) {
    await file.delete();
    print("Community file deleted.");
  }
}
//////////////////////
