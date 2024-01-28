import 'package:country_ip/country_ip.dart';
import 'package:flutter/material.dart';


Future<List<CatgoryItemModel>> getCatlist() async {

  await Future.delayed(Duration(seconds: 2));


  // Initialize an empty list
  List<CatgoryItemModel> catgoryList = [];
  final countryIpResponse = await CountryIp.find();//get country by IP
  if(countryIpResponse!=null){
    catgoryList.add(CatgoryItemModel(countryIpResponse!.country??"World",
        Colors.blue, "🌍"));
  }
  // Adding news categories to the list
  catgoryList.add(CatgoryItemModel("Sport", Colors.amber, "⚽️"));
  catgoryList.add(CatgoryItemModel("Politics", Colors.deepPurple, "🗳️"));
  catgoryList.add(CatgoryItemModel("Technology", Colors.green, "🔧"));
  catgoryList.add(CatgoryItemModel("Entertainment", Colors.greenAccent, "🍿"));
  catgoryList.add(CatgoryItemModel("Fitness", Colors.brown, "💪"));
  catgoryList.add(CatgoryItemModel("Movie", Colors.red, "🎬"));
  catgoryList.add(CatgoryItemModel("Beauty", Colors.indigoAccent, "💄"));
  catgoryList.add(CatgoryItemModel("Aliens", Colors.grey, "👽"));
  catgoryList.add(CatgoryItemModel("Space", Colors.lightGreen, "🚀"));
  catgoryList.add(CatgoryItemModel("Photography", Colors.deepPurple, "📷"));
  catgoryList.add(CatgoryItemModel("Social", Colors.amber, "🤓"));
  catgoryList.add(CatgoryItemModel("Superhero", Colors.red, "🦸‍♂️"));
  catgoryList.add(CatgoryItemModel("Health", Colors.green, "️❤"));
  catgoryList.add(CatgoryItemModel("APPLE", Colors.black, "️🍎"));
  catgoryList.add(CatgoryItemModel("Android", Colors.greenAccent, "️🤖"));


  // Return the list of categories.
  return catgoryList;
}

class CatgoryItemModel{
  String? _name;
  Color? _colors;
  String? _emoji;

  CatgoryItemModel(this._name, this._colors, this._emoji);

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  Color get colors => _colors!;

  set colors(Color value) {
    _colors = value;
  }

  String get emoji => _emoji!;

  set emoji(String value) {
    _emoji = value;
  }
}